#!/bin/bash

set -e
# set -x

# USE the trap if you need to also do manual cleanup after the service is stopped,
#     or need to start multiple services in the one container
trap "echo TRAPed signal" HUP INT QUIT TERM

source env.sh

if [ "$1" = 'start' ]; then
    
    echo "Starting the node..."

	# Path settings
	USERPATH="/data/opt/alastria"
	GETHBINARY=${USERPATH}"/geth"
	GETHPATH=${USERPATH}"/data/geth"
	DATAPATH=${USERPATH}"/data"
	ENVPATH=${USERPATH}"/env"

    # Create the data/geth directory if it does not exist yet
	
    # mkdir -p /root/alastria/data/geth
	mkdir -p ${GETHPATH}
    mkdir -p ${ENVPATH}

    # Make sure we are in /root
    # cd /root
	cd ${USERPATH}
	

    # Generate the nodekey and enode_address if it is not already generated
    # if [ ! -e /root/alastria/data/INITIALIZED ]; then
	if [ ! -e ${DATAPATH}/INITIALIZED ]; then
 
        echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] Generating nodekey and ENODE_ADDRESS"

        # Download the genesis block from the Alastria node repository
        echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] Generating genesis.json and initialize structure..."
        
        # wget -q -O /root/genesis.json https://raw.githubusercontent.com/alastria/alastria-node-quorum-directory/main/genesis.json
		wget -q -O ${USERPATH}/genesis.json https://raw.githubusercontent.com/alastria/alastria-node-quorum-directory/main/genesis.json
        
        echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] ... Storage initialized"
        
        # Initialize the Blockchain structure
        echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] Initialize the Blockchain with the genesis block"
        
        # /usr/local/bin/geth --datadir /root/alastria/data init /root/genesis.json
		${GETHBINARY} --datadir ${DATAPATH} init ${USERPATH}/genesis.json
        
        echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] ... Blockchain initialized"
        
        # Signal that the initialization process has been performed
        # Write the file INITIALIZED in the /root directory
        # echo "INITIALIZED" > /root/alastria/data/INITIALIZED
		echo "INITIALIZED" > ${DATAPATH}/INITIALIZED

    fi
    
    echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] Upgrading enodes list"

    TMPFILE=$(mktemp /tmp/updatePerm.XXXXXX)
    echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] Getting current nodes:"

    for i in boot-nodes.json validator-nodes.json regular-nodes.json ; do
        wget -q -O ${ENVPATH}/${i} https://raw.githubusercontent.com/alastria/alastria-node-quorum-directory/${NODE_BRANCH}/data/${i}
        echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] Getting ${i} nodes..."
    done

    echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] ... nodes recibed"
    
    echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] Parsing correct databases"
    case ${NODE_TYPE} in
        "bootnode")
                cat ${ENVPATH}/boot-nodes.json ${ENVPATH}/validator-nodes.json ${ENVPATH}/regular-nodes.json >> $TMPFILE
        ;;
        "validator")
                cat ${ENVPATH}/boot-nodes.json ${ENVPATH}/validator-nodes.json >> $TMPFILE
        ;;
        "general")
                cat ${ENVPATH}/boot-nodes.json >> $TMPFILE
        ;;
        *)
                echo "ERROR: nodetype not recognized"
                exit 1
        ;;
    esac

    sed -e '1s/^/[\n/' -i $TMPFILE
    sed -e '$s/,$/\n]/' -i $TMPFILE

    cat $TMPFILE > ${DATAPATH}/static-nodes.json
    cat $TMPFILE > ${DATAPATH}/permissioned-nodes.json
    rm -f $TMPFILE
    
    # Set the cron task to update peers every hour (if there are any changes)
    echo "`date +"%M"` * * * * NODE_TYPE=${NODE_TYPE} NODE_BRANCH=${NODE_BRANCH} ${USERPATH}/checkForUpdates.sh" > /tmp/crontab.file
    # crontab /tmp/crontab.file && cron

    # Set the environment variables for the geth arguments from a file
    source ${USERPATH}/geth.common.sh
    source ${USERPATH}/geth.node.${NODE_TYPE}.sh

    # Do not use private transaction manager
    export PRIVATE_CONFIG="ignore"

    # Start geth
    exec ${GETHBINARY} --datadir ${DATAPATH} ${GLOBAL_ARGS} ${METRICS} ${NODE_ARGS} ${LOCAL_ARGS}

    ${GETHBINARY} --exec "admin.nodeInfo.enode" attach ${DATAPATH}/geth.ipc

    echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] ... ENODE_ADDRESS generated."

fi

exec "$@"
