# general ARGS for bootnode
NODE_ARGS="--maxpeers 256"

# For pulling metrics from Prometheus/Grafana server. tcp/6060 should be opened
METRICS="--metrics --metrics.expensive --pprof --pprofaddr=0.0.0.0"
