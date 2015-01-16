FROM python:2.7
MAINTAINER Martijn van Maurik <docker@vmaurik.nl>

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

RUN apt-get update && apt-get dist-upgrade -yq
RUN apt-get install curl swig ruby scons build-essential libreadline-dev libssl-dev lua5.1 liblua5.1-0 pwgen -yq

RUN mkdir -p /usr/src/adchpp

WORKDIR /usr/src/adchpp

RUN curl -L -k \
    "http://downloads.sourceforge.net/project/adchpp/Releases/ADCH%2B%2B%202.11/2.11.2/adchpp_2.11.2_source.tar.gz?r=http%3A%2F%2Fadchpp.sourceforge.net%2F&ts=1421336548&use_mirror=netcologne" \
    | tar zxv --strip-components=1 && \
    scons mode=release arch=x64 && \
    cd build && \
    cp -rp release-default-x64 /opt/adchpp && \
    cp -rp /usr/src/adchpp/plugins/Script/examples /opt/adchpp/Scripts && \
    mkdir -p /usr/local/lib/lua/5.1 && \
    ln -s /opt/adchpp/bin/luadchpp.so /usr/local/lib/lua/5.1/luadchpp.so

WORKDIR /opt/adchpp

ADD start.sh /opt/adchpp/start.sh
RUN chmod +x /opt/adchpp/start.sh

VOLUME ["/data"]

EXPOSE 2780

CMD ["./start.sh"]
