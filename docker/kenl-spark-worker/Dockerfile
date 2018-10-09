FROM domacli/kenl-spark-base:0.0.1
LABEL maintainer="kenladmin"
LABEL description="dockerfile base image for spark-worker"

ENV DEBIAN_FRONTEND noninteractive

USER sparkuser

ADD scripts/spark-worker-entrypoint.sh ${SPARK_HOME}/

ENV SPARK_MASTER "spark://kenl-spark-master:7077"

# EXPOSE $SPARK_WORKER_WEBUI_PORT
EXPOSE 8081 8082 8083 

WORKDIR $SPARK_HOME
ENTRYPOINT ["./spark-worker-entrypoint.sh"]