#!/bin/bash

if [[ ! -f "/data/adchpp.xml" ]]
then
    cp /usr/src/adchpp/etc/adchpp.xml /data
fi

if [[ ! -f "/data/Script.xml" ]]
then
    cp /usr/src/adchpp/etc/Script.xml /data
fi

/opt/adchpp/bin/adchppd -c /data
