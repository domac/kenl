#!/bin/bash

WORKSPACE=$(cd $(dirname $0)/; pwd)

dockerimages=( kenl-base:0.0.1 kenl-kafka-base:0.0.1 kenl-kafka-broker:0.0.1 kenl-zookeeper:0.0.1 kenl-spark-base:0.0.1 kenl-spark-master:0.0.1 kenl-spark-worker:0.0.1 )
for name in ${dockerimages[@]}
do  
    docker pull domacli/${name}
done


thirdparty=( kenl-elasticsearch kenl-logstash kenl-kibana kenl-cerebro )
for name in ${thirdparty[@]}
do  
    cd $WORKSPACE/../docker/${name} && docker build  .
done
