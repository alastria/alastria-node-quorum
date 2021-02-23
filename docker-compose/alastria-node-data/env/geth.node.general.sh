# general ARGS for general/regular node
# Example - Enable RCP connections
NODE_ARGS=" --rpc --rpcaddr 127.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum,istanbul --rpcport 22000"
# Example - Enable WS connections
# NODE_ARGS=${NODE_ARGS}" --ws --wsaddr 127.0.0.0 --wsport 22001 --wsorigins source.com"