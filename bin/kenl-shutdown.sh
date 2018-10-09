#!/bin/bash

WORKSPACE=$(cd $(dirname $0)/; pwd)
LOGFILE="${WORKSPACE}/install_docker.log"
function echoerror() {
    printf "${RC} * ERROR${EC}: $@\n" 1>&2;
}

function kenl_shutdown()
{
    echo "[KENL-SHUTDOWN-INFO] stop kenl docker container now ..."
    docker stop $(docker ps -aq) >> $LOGFILE 2>&1
    ERROR=$?
    if [ $ERROR -ne 0 ]; then
        echoerror "could not shutdown kenl  (Error Code: $ERROR)."
        echo "[KENL-STARTUP-INFO] shutdown kenl docker fail"
        exit 1
    fi
    #echo "[KENL-SHUTDOWN-INFO] clean docker container now ..."
    #docker rm $(docker ps -aq)
    echo "[KENL-SHUTDOWN-INFO] shutdown kenl docker finish. "
}

kenl_shutdown