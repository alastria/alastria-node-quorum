# This is the NETID for Alastria RedT
NETID="83584648538"
# The P2P network listening port
P2P_PORT="21000"

# The timeout for the IBFT protocol execution (inactivity of the proposer)
ISTANBUL_REQUESTTIMEOUT="10000"

# Blockchain sync mode
SYNCMODE="fast"
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
--vmodule $VMODULE \
--nousb "

# Any additional arguments
LOCAL_ARGS=""