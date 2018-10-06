FROM phusion/baseimage:0.10.1
LABEL maintainer="kenladmin"
LABEL description="dockerfile base image"

ENV DEBIAN_FRONTEND noninteractive

RUN echo "[KENL-BASE] setup ubuntu base image" \
  && apt-get update -qq \
  && apt-get install -qqy \
  wget \
  sudo \
  nano

RUN apt-get -qy clean \
  autoremove \
  && rm -rf /var/lib/apt/lists/*

RUN bash -c 'mkdir -pv /opt/kenl/scripts'

CMD ["/sbin/my_init"]