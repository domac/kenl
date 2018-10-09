FROM domacli/kenl-spark-base:0.0.1
LABEL maintainer="kenladmin"
LABEL description="dockerfile base image for spark-master"

ENV DEBIAN_FRONTEND noninteractive

USER sparkuser

ADD scripts/spark-master-entrypoint.sh ${SPARK_HOME}/

ENV SPARK_MASTER_HOST kenl-spark-master
ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080

EXPOSE 8080 7077
WORKDIR $SPARK_HOME
ENTRYPOINT ["./spark-master-entrypoint.sh"]