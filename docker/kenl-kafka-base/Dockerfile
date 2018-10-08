FROM domacli/kenl-base:0.0.1
LABEL maintainer="kenladmin"
LABEL description="dockerfile base image for kafka"

ENV DEBIAN_FRONTEND noninteractive

RUN echo "[KENL-KAFKA-BASE] Updating Ubuntu base image.." \
  && apt-get update -qq \
  && echo "[KENL-KAFKA-BASE] Extracting templates from packages.." \
  && apt-get install -qqy \
  openjdk-8-jre-headless

RUN apt-get -qy clean \
  autoremove

# *********** Creating the right directories ***************
RUN bash -c 'mkdir -pv /opt/kenl/kafka'
 
# *********** Install Kafka ***************
ENV KAFKA_VERSION=1.1.0
ENV KAFKA_LOGS_PATH=/var/log/kafka
ENV KAFKA_CONSOLE_LOG=/var/log/kafka/kenl-kafka.log
ENV KAFKA_HOME=/opt/kenl/kafka/kafka_2.11-${KAFKA_VERSION}

RUN wget -qO- http://mirrors.ocf.berkeley.edu/apache/kafka/1.1.0/kafka_2.11-${KAFKA_VERSION}.tgz | sudo tar xvz -C /opt/kenl/kafka/ \
  && mkdir -v $KAFKA_LOGS_PATH