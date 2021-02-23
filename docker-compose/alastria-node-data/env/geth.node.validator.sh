# validator ARGS for validator node
NODE_ARGS=" --maxpeers 100 --mine --minerthreads $(grep -c "processor" /proc/cpuinfo)"