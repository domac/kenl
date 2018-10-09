#!/bin/bash

WORKSPACE=$(cd $(dirname $0)/; pwd)
OPENRESTYDIR="/usr/local/openresty"
OPENRESTYCONF="/etc/openresty"
NGINXBIN="/usr/local/openresty/nginx/sbin/nginx"
LOGFILE="${WORKSPACE}/install_gateway.log"


function get_host_ip()
{
    echo "[KENL-GATEWAY-INFO] Obtaining current host IP.."
    host_ip=$(ip route get 1 | awk '{print $NF;exit}')
}

function evn_prepare()
{
    mkdir -p /data/logs/kenl

    get_host_ip

    kafka_environment
}


function kafka_environment()
{
    cd $WORKSPACE/../gateway/lualib/kenl_gateway
    sed -i "s/\"kenl-kafka-broker\"/\"$host_ip\"/g" config.lua
    sed -i "s/\"kenl-kafka-broker2\"/\"$host_ip\"/g" config.lua
}

function setup_gateway()
{
    if [ -d "${OPENRESTYDIR}/lualib" ]; then
        echo "setup gateway start" >> $LOGFILE 2>&1
        mkdir -p ${OPENRESTYCONF}
        cd $WORKSPACE/../gateway/lualib && cp -r kenl_gateway ${OPENRESTYDIR}/lualib/
        cd $WORKSPACE/../gateway && cp -r conf ${OPENRESTYCONF}/
    else
        echo "setup gateway fail, openresty was not installed" >> $LOGFILE 2>&1
    fi
}


function openresty_reload()
{
    echo "[KENL-GATEWAY-INFO] OPENRESTY RELOAD"
    $NGINXBIN -c $OPENRESTYCONF/conf/nginx.conf -s reload >> $LOGFILE 2>&1
}

function install_lua_resty_kafka()
{
    cd $WORKSPACE/../gateway
    rm -rf lua-resty-kafka-master
    wget https://github.com/doujiang24/lua-resty-kafka/archive/master.zip
    unzip master.zip
    cp -r $WORKSPACE/../gateway/lua-resty-kafka-master/lib/resty/kafka/  ${OPENRESTYDIR}/lualib/resty/
}

# *********** KENL INSTALL GATEWAY ***************

echo "[KENL-GATEWAY-INFO] INSTALL START"

evn_prepare

setup_gateway

install_lua_resty_kafka

echo "[KENL-GATEWAY-INFO] INSTALL FINISH"