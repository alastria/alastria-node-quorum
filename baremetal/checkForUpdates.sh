#!/bin/bash

USERPATH="/root"
ENVPATH=${USERPATH}"/alastria/env"

github_md5sum_regular=$(wget https://raw.githubusercontent.com/alastria/alastria-node-quorum-directory/${NODE_BRANCH}/data/regular-nodes.json --quiet -O - | md5sum)
local_md5sum_regular=$(cat ${ENVPATH}/regular-nodes.json | md5sum)

github_md5sum_boot=$(wget https://raw.githubusercontent.com/alastria/alastria-node-quorum-directory/${NODE_BRANCH}/data/boot-nodes.json --quiet -O - | md5sum)
local_md5sum_boot=$(cat ${ENVPATH}/boot-nodes.json | md5sum)

github_md5sum_validator=$(wget https://raw.githubusercontent.com/alastria/alastria-node-quorum-directory/${NODE_BRANCH}/data/validator-nodes.json --quiet -O - | md5sum)
local_md5sum_validator=$(cat ${ENVPATH}/validator-nodes.json | md5sum)

case ${NODE_TYPE} in
    "bootnode")
        if [ "$github_md5sum_boot" != "$local_md5sum_boot" ] || [ "$github_md5sum_validator" != "$local_md5sum_validator" ] || [ "$github_md5sum_regular" != "$local_md5sum_regular" ]; then
            pkill -f geth
        fi
    ;;
    "validator")
        if [ "$github_md5sum_boot" != "$local_md5sum_boot" ] || [ "$github_md5sum_validator" != "$local_md5sum_validator" ]; then
            pkill -f geth
        fi
    ;;
    "general")
        if [ "$github_md5sum_boot" != "$local_md5sum_boot" ]; then
            pkill -f geth
        fi
    ;;
    *)
        echo "ERROR: nodetype not recognized"
        exit 1
    ;;
esac
