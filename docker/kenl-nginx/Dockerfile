FROM domacli/kenl-base:0.0.1
LABEL maintainer="kenladmin"
LABEL description="dockerfile base image for nginx"

ENV DEBIAN_FRONTEND noninteractive

# *********** Installing Prerequisites ***************
# -qq : No output except for errors
RUN echo "[KENL-NGINX] updating docker base image.." \
  && apt-get update -qq

RUN apt-get -qy clean \
  autoremove

# *********** Adding KENL scripts and files to Container ***************
ADD scripts/nginx-entrypoint.sh /opt/kenl/scripts/
RUN chmod +x /opt/kenl/scripts/nginx-entrypoint.sh

# *********** Installing Nginx ***************
RUN apt-get install -qqy nginx
RUN apt-get update -qq

# *********** RUN KENL ***************
EXPOSE 80 24080
WORKDIR "/opt/kenl/scripts/"
ENTRYPOINT ["./nginx-entrypoint.sh"]