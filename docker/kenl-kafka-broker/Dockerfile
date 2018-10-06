FROM  kenl-kafka-base:0.0.1

LABEL maintainer="kenladmin"
LABEL description="dockerfile base image for kafka broker"

ENV DEBIAN_FRONTEND noninteractive

ENV KAFKA_SCRIPT=$KAFKA_HOME/bin/kafka-server-start.sh
ENV KAFKA_CONFIG=$KAFKA_HOME/config/server.properties

# *********** Configure Kafka Broker ***************
RUN mv $KAFKA_CONFIG ${KAFKA_HOME}/config/backup_server.properties
ADD server.properties ${KAFKA_HOME}/config/
ADD scripts/kafka-entrypoint.sh /opt/kenl/scripts/
RUN chmod +x /opt/kenl/scripts/kafka-entrypoint.sh

EXPOSE $KAFKA_BROKER_PORT
WORKDIR "/opt/kenl/scripts/"
ENTRYPOINT ["./kafka-entrypoint.sh"]