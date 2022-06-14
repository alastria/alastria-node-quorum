# general ARGS for general/regular node

# Example - Enable RPC connections
NODE_ARGS=' --rpc --rpcaddr 0.0.0.0 --rpcport 22000 --rpccorsdomain "*" --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum,istanbul'

# The Ethstats server where to send the info
METRICS=" --ethstats $NODE_NAME:bb98a0b6442386d0cdf8a31b267892c1@netstats.telsius.alastria.io:80"

# Example - Enable WS connections
# NODE_ARGS=${NODE_ARGS}" --ws --wsaddr 0.0.0.0 --wsport 22001 --wsorigins source.com"
