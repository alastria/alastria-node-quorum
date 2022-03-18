FROM ubuntu:20.04

ENV TZ=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update 
RUN apt-get -y install \
        wget \
        nano \
        vim \       
    && apt-get autoremove \
    && apt-get clean

RUN apt-get install -y golang

ENV VER="v20.10.0"

WORKDIR /root
RUN wget -O geth_${VER}_linux_amd64.tar.gz https://artifacts.consensys.net/public/go-quorum/raw/versions/${VER}/geth_${VER}_linux_amd64.tar.gz
RUN tar zxvf geth_${VER}_linux_amd64.tar.gz -C /usr/local/bin

COPY entrypoint.sh /usr/local/bin/
RUN ["chmod", "+x", "/usr/local/bin/entrypoint.sh"]

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
CMD ["start"]