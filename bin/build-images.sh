#!/bin/bash

WORKSPACE=$(cd $(dirname $0)/; pwd)

cd $WORKSPACE/../docker/kenl-base && docker build -t kenl-base:0.0.1 .

cd $WORKSPACE/../docker/kenl-kafka-base && docker build -t kenl-kafka-base:0.0.1 .

cd $WORKSPACE/../docker/kenl-zookeeper && docker build -t kenl-zookeeper:0.0.1 .