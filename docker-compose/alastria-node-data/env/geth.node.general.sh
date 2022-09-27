# general ARGS for general/regular node

# Enable RPC connections
NODE_ARGS=' --rpc --rpcaddr 0.0.0.0 --rpcport 22000 --rpccorsdomain=* --rpcvhosts=* --rpcapi admin,db,eth,debug,net,shh,txpool,personal,web3,quorum'

# For pulling metrics from Prometheus/Grafana server. tcp/6060 should be opened
METRICS="--metrics --metrics.expensive --pprof --pprofaddr=0.0.0.0"

# Enable WS connections
NODE_ARGS=${NODE_ARGS}' --ws --wsaddr 0.0.0.0 --wsport 22001 --wsorigins=* --wsapi admin,db,eth,debug,net,shh,txpool,personal,web3,quorum'
