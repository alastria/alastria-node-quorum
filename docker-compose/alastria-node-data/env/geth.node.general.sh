# general ARGS for general/regular node

# Enable RPC connections
NODE_ARGS=' --http --http.addr 0.0.0.0 --http.port 22000 --http.corsdomain=* --http.vhosts=* --http.api admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum,istanbul'

# For pulling metrics from Prometheus/Grafana server. tcp/6060 should be opened
METRICS="--metrics --metrics.expensive --pprof --pprof.addr=0.0.0.0"

# Enable WS connections
NODE_ARGS=${NODE_ARGS}' --ws --ws.addr 0.0.0.0 --ws.port 22001 --ws.origins=* --ws.api admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum,istanbul'
