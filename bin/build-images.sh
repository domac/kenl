#!/bin/bash

WORKSPACE=$(cd $(dirname $0)/; pwd)

version="0.0.1"
dockerimages=( kenl-base kenl-kafka-base kenl-kafka-broker kenl-zookeeper )

for name in ${dockerimages[@]}
do  
    #cd $WORKSPACE/../docker/${name} && docker build -t ${name}:${version} .
    docker pull domacli/${name}:${version}
done