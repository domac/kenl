#!/bin/bash

WORKSPACE=$(cd $(dirname $0)/; pwd)
LOGFILE="${WORKSPACE}/install_docker.log"
function echoerror() {
    printf "${RC} * ERROR${EC}: $@\n" 1>&2;
}

function kenl_start()
{
    cd $WORKSPACE/../docker 
    echo "[KENL-STARTUP-INFO] running kenl docker via docker-compose"
    docker-compose -f docker-compose-kenl.yml up --build -d >> $LOGFILE 2>&1
    ERROR=$?
    if [ $ERROR -ne 0 ]; then
        echoerror "Could not run KENL via docker-compose (Error Code: $ERROR)."
        echo "[KENL-STARTUP-INFO] running kenl docker fail"
        exit 1
    fi
    echo "[KENL-STARTUP-INFO] running kenl docker success"
}

kenl_start