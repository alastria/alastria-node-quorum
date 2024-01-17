#!/bin/sh

set -e

echo "Starting the node..."

# Create the data/geth directory if it does not exist yet
# uses the opt-path to not collide with root users
mkdir -p /opt/alastria/data/geth

# Make sure we are in /root
cd /opt

# Geth arguments from the env vars
GLOBAL_ARGS="--networkid $NETID \
--identity $NODE_NAME \
--permissioned \
--cache $CACHE \
--port $P2P_PORT \
--istanbul.requesttimeout $ISTANBUL_REQUESTTIMEOUT \
--verbosity $VERBOSITY \
--emitcheckpoints \
--targetgaslimit $TARGETGASLIMIT \
--syncmode $SYNCMODE \
--gcmode $GCMODE \
--vmodule $VMODULE \
--http.addr='$LOCAL_INTERFACE' \
--ws.addr='$LOCAL_INTERFACE' \
--nat extip:$EXTERNAL_IP \
--nousb "

# Generate the nodekey and enode_address if it is not already generated
if [ ! -e /opt/alastria/data/INITIALIZED ]; then

    echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] Generating nodekey and ENODE_ADDRESS"

    # Download the genesis block from the Alastria node repository
    echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] Generating genesis.json and initialize structure..."
    
    wget -q -O /opt/alastria/genesis.json https://raw.githubusercontent.com/alastria/alastria-node-quorum-directory/main/genesis.json
    
    echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] ... Storage initialized"
    
    # Initialize the Blockchain structure
    echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] Initialize the Blockchain with the genesis block"
    
    /usr/local/bin/geth --datadir /opt/alastria/data/ init /opt/alastria/genesis.json
    
    echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] ... Blockchain initialized"
    
    # Signal that the initialization process has been performed
    # Write the file INITIALIZED in the /root directory
    echo "INITIALIZED" > /opt/alastria/data/INITIALIZED

fi

echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] Upgrading enodes list"

TMPFILE=$(mktemp /tmp/updatePerm.XXXXXX)
echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] Getting current nodes:"

for i in boot-nodes.json validator-nodes.json regular-nodes.json ; do
    wget -q -O /opt/alastria/env/${i} https://raw.githubusercontent.com/alastria/alastria-node-quorum-directory/${NODE_BRANCH}/data/${i}
    ls -l /opt/alastria/env/
    echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] Getting ${i} nodes..."
done

echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] ... nodes recibed"

echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] Parsing correct databases"
case ${NODE_TYPE} in
    "bootnode")
            cat /opt/alastria/env/boot-nodes.json /root/alastria/env/validator-nodes.json /opt/alastria/env/regular-nodes.json >> $TMPFILE
    ;;
    "validator")
            cat /opt/alastria/env/boot-nodes.json /opt/alastria/env/validator-nodes.json >> $TMPFILE
    ;;
    "general")
            cat /opt/alastria/env/boot-nodes.json >> $TMPFILE
    ;;
    *)
            echo "ERROR: nodetype not recognized"
            exit 1
    ;;
esac

sed -e '1s/^/[\n/' -i $TMPFILE
sed -e '$s/,$/\n]/' -i $TMPFILE

cat $TMPFILE > /opt/alastria/data/static-nodes.json
cat $TMPFILE > /opt/alastria/data/permissioned-nodes.json

# Start the geth node
export PRIVATE_CONFIG="ignore"

# Start geth

echo "--datadir /opt/alastria/data ${GLOBAL_ARGS} ${METRICS} ${NODE_ARGS} ${LOCAL_ARGS}"
geth --datadir /opt/alastria/data ${GLOBAL_ARGS} ${METRICS} ${NODE_ARGS} ${LOCAL_ARGS}
echo "nect"

geth --exec "admin.nodeInfo.enode" attach /opt/alastria/data/geth.ipc

echo "INFO [00-00|00:00:00.000|entrypoint.sh:${LINENO}] ... ENODE_ADDRESS generated."