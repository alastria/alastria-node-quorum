# validator ARGS for validator node
NODE_ARGS=" --maxpeers 32 --mine --miner.gastarget 8000000 --miner.gaslimit 10000000 --miner.threads $(grep -c "processor" /proc/cpuinfo) --miner.extradata $NODE_NAME"

# For pulling metrics from Prometheus/Grafana server. tcp/6060 should be opened
METRICS="--metrics --metrics.expensive --pprof --pprof.addr=0.0.0.0"
