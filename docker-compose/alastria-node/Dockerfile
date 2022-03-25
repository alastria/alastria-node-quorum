FROM alpine:latest

ENV TZ=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apk update && apk add wget nano vim 

#we need the go version installed from apk to bootstrap the custom version built from source
RUN apk add go gcc bash musl-dev openssl-dev ca-certificates && update-ca-certificates

#In case we need a specific version of GO
#
#ARG GOLANG_VERSION=1.14.3
#RUN wget https://dl.google.com/go/go$GOLANG_VERSION.src.tar.gz && tar -C /usr/local -xzf go$GOLANG_VERSION.src.tar.gz
#
#RUN cd /usr/local/go/src && ./make.bash
#
#ENV PATH=$PATH:/usr/local/go/bin
#
#RUN rm go$GOLANG_VERSION.src.tar.gz

#we delete the apk installed version to avoid conflict
#RUN apk del go

#Installing glibc provides Alpine methods and functionalities for binaries
ENV GLIBC_REPO=https://github.com/sgerrand/alpine-pkg-glibc
ENV GLIBC_VERSION=2.30-r0

RUN set -ex && \
    apk --update add libstdc++ curl && \
    for pkg in glibc-${GLIBC_VERSION} glibc-bin-${GLIBC_VERSION}; \
        do curl -sSL ${GLIBC_REPO}/releases/download/${GLIBC_VERSION}/${pkg}.apk -o /tmp/${pkg}.apk; done && \
    apk add --allow-untrusted /tmp/*.apk && \
    rm -v /tmp/*.apk && \
    /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib

ENV VER="v21.1.0"

WORKDIR /root
RUN wget -O geth_${VER}_linux_amd64.tar.gz https://artifacts.consensys.net/public/go-quorum/raw/versions/${VER}/geth_${VER}_linux_amd64.tar.gz
RUN tar zxvf geth_${VER}_linux_amd64.tar.gz -C /usr/local/bin

COPY entrypoint.sh /usr/local/bin/
RUN ["chmod", "+x", "/usr/local/bin/entrypoint.sh"]

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
CMD ["start"]

