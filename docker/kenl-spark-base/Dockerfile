FROM domacli/kenl-base:0.0.1
LABEL maintainer="kenladmin"
LABEL description="dockerfile base image for spark"

ENV DEBIAN_FRONTEND noninteractive

# *********** Installing Prerequisites ***************
# -qq : No output except for errors
RUN echo "[KENL-SPARK-BASE] updating docker base image.." \
  && apt-get update -qq \
  && echo "[KENL-SPARK-BASE] extracting templates from packages.." \
  && apt-get install -qqy \
  openjdk-8-jre-headless

RUN apt-get -qy clean \
  autoremove

# *********** Creating the right directories ***************
RUN bash -c 'mkdir -pv /opt/kenl/spark'

# *********** Install Spark ***************
ENV SPARK_VERSION=2.3.1
ENV APACHE_HADOOP_VERSION=2.7
RUN wget -qO- http://mirror.reverse.net/pub/apache/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${APACHE_HADOOP_VERSION}.tgz | sudo tar xvz -C /opt/kenl/spark --strip-components=1

# Adding SPARK environment variables
ENV SPARK_HOME=/opt/kenl/spark
ENV SPARK_LOGS=$SPARK_HOME/logs

RUN mkdir -p $SPARK_LOGS

# Adding SPARK User
ENV SPARK_GID=710
ENV SPARK_UID=710
ENV SPARK_USER=sparkuser
RUN groupadd -g ${SPARK_GID} ${SPARK_USER} \
  && useradd -u ${SPARK_UID} -g ${SPARK_GID} -d ${SPARK_HOME} --no-create-home ${SPARK_USER} \
  && chown -R ${SPARK_USER}:${SPARK_USER} ${SPARK_HOME}