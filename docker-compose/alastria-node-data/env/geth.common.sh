# This is the NETID for Alastria RedT
NETID="83584648538"
# The P2P network listening port
P2P_PORT="21000"

# The timeout for the IBFT protocol execution (inactivity of the proposer)
ISTANBUL_REQUESTTIMEOUT="10000"

# Blockchain sync mode
SYNCMODE="full"
# Cache size in MB
CACHE="4196"
# Blockchain garbage collection mode
GCMODE="full"
# Target gas limit sets the artificial target gas floor for the blocks to mine
TARGETGASLIMIT="8000000"
# General logging verbosity: 0=silent, 1=error, 2=warn, 3=info, 4=debug, 5=detail
VERBOSITY="3"
# Per-module verbosity: comma-separated list of <pattern>=<level> (e.g. eth/*=5,p2p=4)
VMODULE="consensus/istanbul/core/core.go=5"

################################################
# CONSIDER EDITING FROM HERE
################################################

# Geth arguments
GLOBAL_ARGS="--networkid $NETID \
--identity $NODE_NAME \
--permissioned \
--cache $CACHE \
--port $P2P_PORT \
--istanbul.requesttimeout $ISTANBUL_REQUESTTIMEOUT \
--verbosity $VERBOSITY \
--emitcheckpoints \
--targetgaslimit $TARGETGASLIMIT \
--syncmode $SYNCMODE \
--gcmode $GCMODE \
--vmodule $VMODULE "

# The Ethstats server where to send the info
NETSTATS_METRICS=" --ethstats $NODE_NAME:bb98a0b6442386d0cdf8a31b267892c1@netstats.telsius.alastria.io:80"

# Influx
INFLUX_METRICS=" --metrics --metrics.influxdb --metrics.influxdb.endpoint http://geth-metrics.planisys.net:8086 --metrics.influxdb.database alastria --metrics.influxdb.username alastriausr --metrics.influxdb.password ala0str1AX1 --metrics.influxdb.host.tag=${NODE_NAME}"

# Influx && geth > 1.9
# INFLUX_METRICS=" --metrics --metrics.expensive  --pprof --pprofaddr 0.0.0.0 --pprofport 9545 --metrics.influxdb --metrics.influxdb.endpoint http://geth-metrics.planisys.net:8086 --metrics.influxdb.database alastria --metrics.influxdb.username alastriausr --metrics.influxdb.password ala0str1AX1 --metrics.influxdb.tags host=${NODE_NAME}"

# Any additional arguments
LOCAL_ARGS=""