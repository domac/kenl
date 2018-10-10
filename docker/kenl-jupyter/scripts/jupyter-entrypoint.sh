#!/bin/bash

echo "[KENL-JUPYTER] starting postgresql."
service postgresql start

echo "[KENL-JUPYTER] creating postgres user and hive_metastore.."
sudo -u postgres psql <<MYQUERY
CREATE USER hive;
ALTER ROLE hive WITH PASSWORD 'sparkpassword';
CREATE DATABASE hive_metastore;
GRANT ALL PRIVILEGES ON DATABASE hive_metastore TO hive;
MYQUERY

echo "[KENL-JUPYTER] restarting postgresql."
service postgresql restart

# ************* Creating JupyterHub Users ***************
declare -a users_index=("kenladmin" "kenladmin2" "kenladmin3")

JUPYTERHUB_GID=711
JUPYTERHUB_UID=711
JUPYTERHUB_HOME=/opt/kenl/jupyterhub
JUPYTER_HOME=/opt/kenl/jupyter

echo "[KENL-JUPYTER] creating JupyterHub group..."
groupadd -g ${JUPYTERHUB_GID} jupyterhub

for u in ${users_index[@]}; do 
  echo "[KENL-JUPYTER] creating jupyterHub user ${u} .."
  student_password="${u}@6666"
  echo $student_password >> /opt/kenl/user_credentials.txt
  
  JUPYTERHUB_USER_DIRECTORY=${JUPYTERHUB_HOME}/${u}
  mkdir -v $JUPYTERHUB_USER_DIRECTORY

  useradd -p $(openssl passwd -1 ${student_password}) -u ${JUPYTERHUB_UID} -g ${JUPYTERHUB_GID} -d $JUPYTERHUB_USER_DIRECTORY --no-create-home -s /bin/bash ${u}
  
  echo "[KENL-JUPYTER] copying notebooks to ${JUPYTERHUB_USER_DIRECTORY} notebooks directory ..."
  cp -R ${JUPYTER_HOME}/notebooks ${JUPYTERHUB_USER_DIRECTORY}/notebooks
  chown -R ${u}:jupyterhub $JUPYTERHUB_USER_DIRECTORY
  chmod 700 -R $JUPYTERHUB_USER_DIRECTORY

  ((JUPYTERHUB_UID=$JUPYTERHUB_UID + 1))
done

chmod 777 -R /var/log/spark
chmod 777 -R /opt/kenl/spark

exec "$@"
