#!/bin/bash

set -e
set -x

# This is the NETID for Alastria RedT
export NETID="83584648538"
# The P2P network listening port
export P2P_PORT="21000"

# The timeout for the IBFT protocol execution (inactivity of the proposer)
export ISTANBUL_REQUESTTIMEOUT="10000"

# Blockchain sync mode
export SYNCMODE="fast"
# Cache size in MB
export CACHE="4196"
# Blockchain garbage collection mode
export GCMODE="full"
# Target gas limit sets the artificial target gas floor for the blocks to mine
export TARGETGASLIMIT="8000000"
# General logging verbosity: 0=silent, 1=error, 2=warn, 3=info, 4=debug, 5=detail
export VERBOSITY="3"
# Per-module verbosity: comma-separated list of <pattern>=<level> (e.g. eth/*=5,p2p=4)
export VMODULE="consensus/istanbul/core/core.go=5"

################################################
# CONSIDER EDITING FROM HERE
################################################

# Geth arguments
export GLOBAL_ARGS="--networkid $NETID \
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
export LOCAL_ARGS=""

