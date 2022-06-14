# general ARGS for bootnode
NODE_ARGS="--maxpeers 256"

# The Ethstats server where to send the info
METRICS=" --ethstats $NODE_NAME:1bdf9149555dbb77ec68aadce67897cf@netstats.core-redt.alastria.io"

# The Grafana server for pulling metrics. tcp/6060 should be opened
# Uncomment the following line only in GoQuorum versions >= v21.10.0
# METRICS=" --metrics --pprof --pprof.addr=0.0.0.0"
