#!/bin/bash

WORKSPACE=$(cd $(dirname $0)/; pwd)
LOGFILE="${WORKSPACE}/install_docker.log"
function echoerror() {
    printf "${RC} * ERROR${EC}: $@\n" 1>&2;
}

function kenl_start()
{
    cd $WORKSPACE/../docker 
    echo "[KENL-STARTUP-INFO] running KENL via docker-compose"
    docker-compose -f docker-compose-kenl.yml up --build -d >> $LOGFILE 2>&1
    ERROR=$?
    if [ $ERROR -ne 0 ]; then
        echoerror "Could not run KENL via docker-compose (Error Code: $ERROR)."
        exit 1
    fi
}

kenl_start