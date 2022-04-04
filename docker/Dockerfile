FROM quorumengineering/quorum:21.10

ENV NODE_BRANCH="main"
ENV NODE_NAME="alastria-node"
ENV NODE_TYPE="general"
ENV NETID="83584648538"
ENV P2P_PORT="21000"
ENV ISTANBUL_REQUESTTIMEOUT="10000"
ENV SYNCMODE="fast"
ENV CACHE="4196"
ENV GCMODE="full"
ENV TARGETGASLIMIT="8000000"
ENV VERBOSITY="3"
ENV VMMODULE="consensus/istanbul/core/core.go=5"
ENV LOCAL_ARGS=""
ENV EXTERNAL_IP="1.2.3.4"
ENV LOCAL_INTERFACE="0.0.0.0"
# default args for a general node
ENV NODE_ARGS="--http --http.api admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum,istanbul --http.port 22000"
ENV METRICS=" --metrics --pprof --pprof.addr=0.0.0.0"


COPY ./entrypoint.sh /usr/local/bin/
RUN ["chmod", "-R", "a+rwx", "/usr/local/bin"]

RUN ["mkdir", "/opt/alastria"]
RUN ["mkdir", "/opt/alastria/env"]
RUN ["chmod", "-R", "a+rwx", "/opt/alastria"]

# never let a container run as root
USER 1001
RUN ls -l /usr/local/bin

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]