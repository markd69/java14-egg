FROM    ubuntu:18.04

MAINTAINER  Mark David

RUN apt update \
    && apt upgrade -y \
    && apt autoremove -y \
    && apt autoclean \
    && apt -y install curl software-properties-common locales git cmake wget iproute2 \
    && useradd -d /home/container -m container

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# java 14
RUN add-apt-repository ppa:linuxuprising/java \
    && apt-get update -y 
    && apt-get install openjdk-14-jre -y \
    && apt-get -y install oracle-java14-set-default


USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
