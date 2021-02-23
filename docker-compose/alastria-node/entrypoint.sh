#!/bin/bash

set -e

# USE the trap if you need to also do manual cleanup after the service is stopped,
#     or need to start multiple services in the one container
trap "echo TRAPed signal" HUP INT QUIT TERM

if [ "$1" = 'start' ]; then
    
    echo "Starting the node..."

    # Create the data/geth directory if it does not exist yet
    mkdir -p /root/alastria/data/geth

    # Make sure we are in /root
    cd /root

    # Generate the nodekey and enode_address if it is not already generated
    if [ ! -e /root/alastria/data/INITIALIZED ]; then
 
        echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] Generating nodekey and ENODE_ADDRESS"
        
        # Create the nodekey in the /root/alastria/data/geth directory
        /usr/local/bin/bootnode -genkey /root/alastria/data/nodekey

        # Get the enode key and write it in a local file for later starts of the docker
        /usr/local/bin/bootnode -nodekey /root/alastria/data/nodekey -writeaddress > /root/alastria/data/ENODE_ADDRESS

        echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] ... ENODE_ADDRESS generated."

        # Download the genesis block from the Alastria node repository
        echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] Generating genesis.json and initialize structure..."
        
        wget -q -O /root/genesis.json https://raw.githubusercontent.com/alastria/alastria-node/testnet2/data/genesis.json
        
        echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] ... Storage initialized"
        
        # Initialize the Blockchain structure
        echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] Initialize the Blockchain with the genesis block"
        
        geth --datadir /root/alastria/data init /root/genesis.json
        
        echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] ... Blockchain initialized"
        
        # Signal that the initialization process has been performed
        # Write the file INITIALIZED in the /root directory
        echo "INITIALIZED" > /root/alastria/data/INITIALIZED

    fi
    
    echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] Upgrading enodes list"

    TMPFILE=$(mktemp /tmp/updatePerm.XXXXXX)
    echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] Getting current nodes:"

    for i in boot-nodes.json validator-nodes.json regular-nodes.json ; do
        wget -q -O /root/alastria/env/${i} https://raw.githubusercontent.com/alastria/alastria-node/${NODE_BRANCH}/data/${i}
        echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] Getting ${i} nodes..."
    done

    echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] ... nodes recibed"
    
    echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] Parsing correct databases"
    case ${NODE_TYPE} in
        "bootnode")
                cat /root/alastria/env/boot-nodes.json /root/alastria/env/validator-nodes.json /root/alastria/env/regular-nodes.json >> $TMPFILE
        ;;
        "validator")
                cat /root/alastria/env/boot-nodes.json /root/alastria/env/validator-nodes.json >> $TMPFILE
        ;;
        "general")
                cat /root/alastria/env/boot-nodes.json >> $TMPFILE
        ;;
        *)
                echo "ERROR: nodetype not recognized"
                exit 1
        ;;
    esac

    sed -e '1s/^/[\n/' -i $TMPFILE
    sed -e '$s/,$/\n]/' -i $TMPFILE

    cat $TMPFILE > /root/alastria/data/static-nodes.json
    cat $TMPFILE > /root/alastria/data/permissioned-nodes.json

    # Set the environment variables for the geth arguments from a file
    source /root/alastria/env/geth.common.sh
    source /root/alastria/env/geth.node.${NODE_TYPE}.sh

    # Start the geth node
    export PRIVATE_CONFIG="ignore"

    # Start geth
    exec /usr/local/bin/geth --datadir /root/alastria/data ${GLOBAL_ARGS} ${NETSTATS_METRICS} ${INFLUX_METRICS} ${NODE_ARGS} ${LOCAL_ARGS}

fi

exec "$@"
