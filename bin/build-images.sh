#!/bin/bash

WORKSPACE=$(cd $(dirname $0)/; pwd)

version="0.0.1"
dockerimages=( kenl-base kenl-kafka-base kenl-kafka-broker kenl-zookeeper )
for name in ${dockerimages[@]}
do  
    docker pull domacli/${name}:${version}
done


thirdparty=( kenl-elasticsearch kenl-logstash kenl-kibana kenl-cerebro )
for name in ${thirdparty[@]}
do  
    cd $WORKSPACE/../docker/${name} && docker build  .
done
