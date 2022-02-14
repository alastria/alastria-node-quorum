#!/bin/bash

# VER="v2.3.0"
# VER="v2.4.0"
# VER="v2.5.0"
# VER="v2.6.0"
# VER="v2.7.0"
# VER="v20.10.0"
VER="v21.10.0"

#
# Download GETH
wget -O geth_${VER}_linux_amd64.tar.gz https://bintray.com/quorumengineering/quorum/download_file?file_path=${VER}/geth_${VER}_linux_amd64.tar.gz
tar zxvf geth_${VER}_linux_amd64.tar.gz -C /usr/local/bin

#
# Create database for geth
rm -rf /home/alastria/data-${VER}
mkdir -p /home/alastria/data-${VER}
wget -O /root/genesis.json https://raw.githubusercontent.com/alastria/alastria-node/testnet2/data/genesis.json
geth --datadir /home/alastria/data-${VER} init /root/genesis.json

#
# Update database
cp /root/nodekey /home/alastria/data-${VER}/geth/nodekey
cp /root/boot-nodes.json /home/alastria/data-${VER}/static-nodes.json
cp /root/boot-nodes.json /home/alastria/data-${VER}/permissioned-nodes.json

export PRIVATE_CONFIG="ignore"
/usr/local/bin/geth --datadir /home/alastria/data-${VER} --networkid 83584648538 --identity REG_DigitelTS-labs_2_2_00 --permissioned --port 21000 --istanbul.requesttimeout 10000 --ethstats REG_DigitelTS-labs_2_2_00:bb98a0b6442386d0cdf8a31b267892c1@netstats.telsius.alastria.io:80 --verbosity 3 --vmdebug --emitcheckpoints --targetgaslimit 8000000 --syncmode full --gcmode full --vmodule consensus/istanbul/core/core.go=5 --nodiscover --cache 4096 2> /tmp/log.${VER}