#!/bin/sh

# *********** Start Kibana services ***************
echo "[KENL-KIBANA] Waiting for elasticsearch URI to be accessible.."
until curl -s kenl-elasticsearch:9200 -o /dev/null; do
    sleep 1
done

echo "[KENL-KIBANA] Starting Kibana service.."
exec /usr/local/bin/kibana-docker &

# *********** Creating Kibana Dashboards, visualizations and index-patterns ***************
echo "[KENL-KIBANA] Running kenl_kibana_setup.sh script..."
/usr/share/kibana/scripts/kibana-setup.sh

tail -f /usr/share/kibana/config/kibana_logs.log