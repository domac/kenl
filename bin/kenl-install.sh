#!/bin/bash

WORKSPACE=$(cd $(dirname $0)/; pwd)
HOSTS=( kenl-elasticsearch kenl-logstash kenl-zookeeper kenl-kibana kenl-kafka-broker kenl-kafka-broker2 kenl-nginx ) 
HOSTS_FILE="/tmp/hosts"
LOGFILE="${WORKSPACE}/kenl-install.log"

function build_data_link()
{
    cd $WORKSPACE/../docker && mkdir -p esdata/_data
    DOCKERPATH=$(cd $(dirname $0)/; pwd)
    ln -sfnv $DOCKERPATH/esdata /var/lib/docker/volumes/esdata
    ln -sfnv $DOCKERPATH/esdata /var/lib/docker/volumes/docker_esdata
}

function get_host_ip()
{
    echo "[KENL-INSTALLATION-INFO] Obtaining current host IP.."
    host_ip=$(ip route get 1 | awk '{print $NF;exit}')
}

function evn_prepare()
{
    set_hosts

    install_docker_compose
}

function set_hosts()
{
    echo "[KENL-INSTALLATION-INFO] LOCAL IP: ${host_ip}"
    for data in ${HOSTS[@]}  
    do  
        if [ `grep -c ${data} ${HOSTS_FILE}` -eq '0' ]; then
            echo "create $host_ip ${data} to ${HOSTS_FILE}"
            echo "$host_ip ${data}" >> ${HOSTS_FILE}
        fi
    done 
}


function install_docker_compose()
{
    if [ -x "$(command -v docker-compose)" ]; then
        echo "[KENL-INSTALLATION-INFO] Docker-compose already installed"
    else 
        echo "[KENL-INSTALLATION-INFO] Installing docker-compose.."
        curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose >> $LOGFILE 2>&1
        chmod +x /usr/local/bin/docker-compose >> $LOGFILE 2>&1
        ERROR=$?
        if [ $ERROR -ne 0 ]; then
            echoerror "Could not install docker-compose (Error Code: $ERROR)."
            exit 1
        fi
    fi
}

function show_banner()
{
    echo " "
    echo "**********************************************"	
    echo "** KENL - gateway for data push processing  **"
    echo "**                                          **"
    echo "** HELK build version: 0.0.1                **"
    echo "** HELK ELK version: 6.3.1                  **"
    echo "**********************************************"
    echo " "
    echo "[KENL-INSTALLATION-INFO] WORKING DIR: ${WORKSPACE}"
}

 # *********** KENL INSTALL pipeline ***************

echo ""

show_banner

get_host_ip

evn_prepare

