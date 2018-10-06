#!/bin/sh


_term() {
  echo "Terminating Nginx Services"
  service nginx stop
  exit 0
}
trap _term SIGTERM

until curl -s kenl-elasticsearch:9200 -o /dev/null; do
    sleep 1
done

echo "[KENL-NGINX] Starting remaining services.."
service nginx restart

echo "[KENL-NGINX] Pushing Nginx Logs to console.."
tail -f /var/log/nginx/*.log