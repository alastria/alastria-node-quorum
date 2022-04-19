# general ARGS for general/regular node

# Example - Enable RCP connections
NODE_ARGS=" --rpc --rpcaddr 127.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum,istanbul --rpcport 22000"

# The Grafana server for pulling metrics. tcp/6060 should be opened
METRICS=" --ethstats $NODE_NAME:bb98a0b6442386d0cdf8a31b267892c1@netstats.telsius.alastria.io:80"

# Example - Enable WS connections
# NODE_ARGS=${NODE_ARGS}" --ws --wsaddr 127.0.0.0 --wsport 22001 --wsorigins source.com"
