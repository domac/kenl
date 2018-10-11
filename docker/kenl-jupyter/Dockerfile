FROM domacli/kenl-spark-base:0.0.1
LABEL maintainer="kenladmin"
LABEL description="dockerfile base image for kafka"

ENV DEBIAN_FRONTEND noninteractive

# *********** Installing Prerequisites ***************
# -qq : No output except for errors
RUN echo "[KENL-JUPYTER] updating docker base image.." \
  && apt-get update -qq
RUN echo "[KENL-JUPYTER] Extracting templates from packages.." \
  && apt-get install -qqy --no-install-recommends \
  curl python3-pip python3-dev python-tk unzip python3-setuptools \
  libcurl4-openssl-dev build-essential libssl-dev libffi-dev \
  libxml2-dev libxslt1-dev zlib1g-dev

# ********** Install Postgresql *********************
RUN echo "[KENL-JUPYTER] Installing Postgresql.." \
  && apt-get install -y --no-install-recommends postgresql

RUN apt-get -qy clean \
  autoremove

# *********** Upgrading PIP ***************
RUN pip3 install --upgrade pip

# *********** Installing Jupyter Hub Prerequisites
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN apt-get install -y --no-install-recommends nodejs

# *********** Installing KENL python packages ***************
RUN pip3 install  -i https://pypi.tuna.tsinghua.edu.cn/simple \
  pandas==0.23.4 \
  altair==2.2.2 \
  vega_datasets \
  jupyter==1.0.0 \
  jupyterlab==0.34.1 \
  jupyterhub==0.9.2

# *********** Installing Jupyter Lab Extension - JupyterHub ***************
RUN npm install -g configurable-http-proxy
RUN jupyter labextension install @jupyterlab/hub-extension@0.11.0

# *********** Creating the Jupyter directories ***************
RUN bash -c 'mkdir -pv /opt/kenl/{es-hadoop,jupyter,jupyterhub}'
RUN mkdir -v /usr/local/share/jupyter/kernels/pyspark3
RUN mkdir -v /var/log/spark

# *********** Configure Jupyterhub ***************
ENV JUPYTER_DIR=/opt/kenl/jupyter

# *********** Adding KENL scripts and files to Container ***************
COPY scripts/jupyter-entrypoint.sh ${JUPYTER_DIR}
COPY notebooks ${JUPYTER_DIR}/notebooks
COPY spark/* ${SPARK_HOME}/conf/
COPY kernels/pyspark_kernel.json /usr/local/share/jupyter/kernels/pyspark3/kernel.json
COPY jupyterhub/jupyterhub_config.py /opt/kenl/jupyter/

# *********** Download ES-Hadoop ***************
ENV ESHADOOP_VERSION=6.4.0
RUN wget https://artifacts.elastic.co/downloads/elasticsearch-hadoop/elasticsearch-hadoop-${ESHADOOP_VERSION}.zip -P /opt/kenl/es-hadoop/ \
  && unzip -j /opt/kenl/es-hadoop/*.zip -d /opt/kenl/es-hadoop/ \
  && rm /opt/kenl/es-hadoop/*.zip

# ********** Download Postgresql JAR *****************
ENV POSTGRESQL_VERSION=42.2.4
RUN sudo wget https://jdbc.postgresql.org/download/postgresql-${POSTGRESQL_VERSION}.jar -P /opt/kenl/spark/jars/

# ********** Set hive.xml file ******************
COPY hive-site.xml /opt/kenl/spark/conf/hive-site.xml

EXPOSE 8000
# *********** RUN KENL ***************
WORKDIR ${JUPYTER_DIR}
ENTRYPOINT ["./jupyter-entrypoint.sh"]
CMD ["/bin/bash","-c","/usr/local/bin/jupyterhub","-f","/opt/kenl/jupyter/jupyterhub_config.py"]