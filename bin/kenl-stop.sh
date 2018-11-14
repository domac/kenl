#!/bin/bash

function kenl_stop() {
    docker ps -a | grep 'kenl-' | awk '{print $NF}' | xargs docker stop
}


kenl_stop