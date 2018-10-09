#!/bin/sh

ln -sf /dev/stdout $SPARK_LOGS/spark-worker.out

echo "[KENL-SPARK-WORKER] starting spark worker service.."
exec /$SPARK_HOME/bin/spark-class org.apache.spark.deploy.worker.Worker \
    --webui-port $SPARK_WORKER_WEBUI_PORT $SPARK_MASTER >> $SPARK_LOGS/spark-worker.out