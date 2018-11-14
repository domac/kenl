#!/bin/bash

function kenl_stop() {
    docker ps -a | grep 'kenl-' | awk '{print $NF}' | xargs docker stop
}


function kenl_start() {
    docker ps -a | grep 'kenl-' | awk '{print $NF}' | xargs docker start
}


function kenl_remove() {
    docker ps -a | grep 'kenl-' | awk '{print $NF}' | xargs docker rm
}


kenl_stop

kenl_remove