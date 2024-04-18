# Dockerfile for building runtime-configurable images

The docker file is based on the [quorumengineering/quorum](https://hub.docker.com/r/quorumengineering/quorum) base image, as provided by the origial maintainers [ConsenSys](https://github.com/ConsenSys/quorum/blob/master/README.md). It implements some sane defaults for running an alastria node, some docker best practices and improvements for running inside kubernetes clusters. Important features(in contrast to the image described at [docker-compose]()../docker-compose)) are:

* does not run as root
* enables runtime-configuration via env-vars, see [Dockerfile](./Dockerfile) for a full list
* supports easier configuration of the external ip-address
* follows the maintained base-image
* reduces dependencies(f.e. no bash)

## Build

```shell
    docker build . -t alastria-node
```

## Rum

```shell
    docker run -e EXTERNAL_IP=<MY_LOADBALANCER_IP> -e NODE_NAME="my-node" -e NODE_TYPE="general"  alastria-node
```    
