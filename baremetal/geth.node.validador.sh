# validator ARGS for validator node
NODE_ARGS=" --maxpeers 32 --mine --minerthreads $(grep -c "processor" /proc/cpuinfo)"

# The Ethstats server where to send the info
METRICS="--metrics --metrics.expensive --pprof --pprofaddr=0.0.0.0"