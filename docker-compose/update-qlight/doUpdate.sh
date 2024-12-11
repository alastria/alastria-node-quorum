#!/bin/bash
#
# Snippet for updating the AlastriaT Full Node to be used as a QlightNodes Server in GoQuorum.
#
# https://docs.goquorum.consensys.io/concepts/qlight-node
# 
# Tested from:
#   v1.9.7-stable-a21e1d44(quorum-v21.1.0)/linux-amd64/go1.15.5
#   v1.9.25-stable-919800f0(quorum-v21.10.0)/linux-amd64/go1.15.6
#   v1.9.25-stable-ff917d28(quorum-v21.10.2066)/linux-amd64/go1.19.4
#

# Stop the container, in order to make the changes without locking the resources
#
# $ sudo docker stop <container_name>
#

# Download the lastest-compatible GoQuorum version
#
VER="v22.4.4"
wget -O geth_${VER}_linux_amd64.tar.gz https://artifacts.consensys.net/public/go-quorum/raw/versions/${VER}/geth_${VER}_linux_amd64.tar.gz
tar zxvf geth_${VER}_linux_amd64.tar.gz -C .

# Update Geth version
#
# $ sudo docker cp ./geth <container_name>:/usr/local/bin/geth
#

# Update deprecated arguments. You can choose the right node for your case.
#
# $ sudo docker cp geth.node.bootnode.sh <container_name>:/root/alastria/env/
# $ sudo docker cp geth.node.general.sh <container_name>:/root/alastria/env/
# $ sudo docker cp geth.node.validator.sh <container_name>:/root/alastria/env/
#

# Start the Container
#
# sudo docker start <container_name>
#

# Test the right update
#
# sudo docker logs <container_name> --tail 20 -f
#