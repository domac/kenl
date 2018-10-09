#!/bin/bash

WORKSPACE=$(cd $(dirname $0)/; pwd)
LOGFILE="${WORKSPACE}/install_docker.log"
function echoerror() {
    printf "${RC} * ERROR${EC}: $@\n" 1>&2;
}

function kenl_shutdown()
{
    cd $WORKSPACE/../docker 
    echo "[KENL-SHUTDOWN-INFO] shutdown KENL via docker-compose"
    docker-compose -f docker-compose-kenl.yml down >> $LOGFILE 2>&1
    ERROR=$?
    if [ $ERROR -ne 0 ]; then
        echoerror "Could not shutdown KENL via docker-compose (Error Code: $ERROR)."
        exit 1
    fi
}

kenl_shutdown