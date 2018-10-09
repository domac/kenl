#!/bin/sh

ln -sf /dev/stdout $SPARK_LOGS/spark-master.out

echo "[KENL-SPARK-MASTER] starting spark master service.."
exec $SPARK_HOME/bin/spark-class org.apache.spark.deploy.master.Master \
    --host $SPARK_MASTER_HOST --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT >> $SPARK_LOGS/spark-master.out