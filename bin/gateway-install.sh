#!/bin/bash

WORKSPACE=$(cd $(dirname $0)/; pwd)
OPENRESTYDIR="/usr/local/openresty"
OPENRESTYCONF="/etc/openresty"
NGINXBIN="/usr/local/openresty/nginx/sbin/nginx"
LOGFILE="${WORKSPACE}/install_gateway.log"

function setup_gateway()
{
    if [ -d "${OPENRESTYDIR}/lualib" ]; then
        echo "setup gateway start" >> $LOGFILE 2>&1
        mkdir -p /etc/openresty
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

# *********** KENL INSTALL GATEWAY ***************

echo "[KENL-GATEWAY-INFO] INSTALL START"

setup_gateway

openresty_reload

echo "[KENL-GATEWAY-INFO] INSTALL FINISH"