################################################
# ALASTRIA NODE BUILDER
################################################

FROM ubuntu:18.04 AS builder

# Define the version of Golang compiler
ARG GOLANG_VERSION="go1.9.5.linux-amd64.tar.gz"
# ARG GOLANG_VERSION="go1.15.2.linux-amd64.tar.gz"

# Define the Quorum version to use
ARG QUORUM_VERSION=v2.2.3
# ARG QUORUM_VERSION=v2.2.4
# ARG QUORUM_VERSION=v2.2.5
# ARG QUORUM_VERSION=v2.6.0
# ARG QUORUM_VERSION=v2.7.0
# ARG QUORUM_VERSION=v20.10.0

# Install basic dependencies and tools
RUN \
    apt-get update && apt-get -y install \
        git \
        curl \
        dnsutils \
        net-tools \
        logrotate \
        software-properties-common unzip wget git\
        make gcc libsodium-dev build-essential libdb-dev zlib1g-dev \
        libtinfo-dev sysvbanner psmisc libleveldb-dev\
        libsodium-dev libdb5.3-dev dnsutils \
    && apt-get autoremove \
    && apt-get clean

# Install Golang compiler in default path: /usr/local/go
RUN wget https://storage.googleapis.com/golang/${GOLANG_VERSION} \
    && tar -C /usr/local -xvzf ${GOLANG_VERSION} \
    && rm -f ${GOLANG_VERSION}

# Set variables for the go installation
ENV PATH=".:${PATH}:/usr/local/go/bin"

# Install Quorum
WORKDIR /root
RUN git clone https://github.com/ConsenSys/quorum.git \
    && cd quorum \
    && git checkout ${QUORUM_VERSION} \
    && make all \
    && cp build/bin/geth /usr/local/bin \
    && cp build/bin/bootnode /usr/local/bin \
    && cd /root

################################################
# ALASTRIA NODE
################################################

FROM ubuntu:18.04 AS production

# Install the minimum required tools in production
RUN \
    apt-get update && apt-get -y install \
        wget \
        nano \
        vim \       
        mc \
    && apt-get autoremove \
    && apt-get clean

# Copy the Quorum/Geth executables from the previous stage
COPY --from=builder /root/quorum/build/bin/* /usr/local/bin/

# Set the volumes to share data with the host
VOLUME /root/alastria

WORKDIR /root

# Copy the entrypoint script from the build context
COPY entrypoint.sh /usr/local/bin/
RUN ["chmod", "+x", "/usr/local/bin/entrypoint.sh"]

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
CMD ["start"]