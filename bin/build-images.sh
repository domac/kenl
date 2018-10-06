#!/bin/bash

cd ../docker/kenl-base && docker build -t kenl-base:0.0.1 .

cd ../docker/kenl-kafka-base && docker build -t kenl-kafka-base:0.0.1 .