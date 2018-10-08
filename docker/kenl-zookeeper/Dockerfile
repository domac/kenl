FROM domacli/kenl-kafka-base:0.0.1
LABEL maintainer="kenladmin"
LABEL description="dockerfile base image for zookeeper"

ENV DEBIAN_FRONTEND noninteractive

# *********** Creating the right directories ***************
RUN bash -c 'mkdir -pv /opt/kenl/zookeeper'

# *********** Install Zookeeper ***************
ENV ZOO_CONF_DIR=/opt/kenl/zookeeper/conf \
    ZOO_DATA_DIR=/opt/kenl/zookeeper/data \
    ZOO_DATA_LOG_DIR=/opt/kenl/zookeeper/datalog \
    ZOO_PORT=2181 \
    ZOO_TICK_TIME=2000 \
    ZOO_INIT_LIMIT=20 \
    ZOO_SYNC_LIMIT=2 \
    ZOO_MAX_CLIENT_CNXNS=60 \
    ZOO_LOGS_PATH=/var/log/zookeeper \
    ZOO_LOGS_FILE=${ZOO_LOGS_PATH}/zookeeper.log

# *********** Configure zookeeper ***************
RUN mkdir -p "$ZOO_CONF_DIR" "$ZOO_DATA_LOG_DIR" "$ZOO_DATA_DIR" "$ZOO_LOGS_PATH"
ADD scripts/zookeeper-entrypoint.sh /opt/kenl/scripts/
RUN chmod +x /opt/kenl/scripts/zookeeper-entrypoint.sh

VOLUME ["$ZOO_DATA_DIR", "$ZOO_DATA_LOG_DIR"]

EXPOSE $ZOO_PORT 2888 3888
WORKDIR "/opt/kenl/scripts/"
ENTRYPOINT ["./zookeeper-entrypoint.sh"]