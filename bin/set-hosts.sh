#!bin/sh

host_ip=$(ip route get 1 | awk '{print $NF;exit}')

echo "[KENL-INSTALLATION-INFO] Obtaining current host IP.."
echo $host_ip

hosts=( kenl-elasticsearch kenl-logstash kenl-zookeeper kenl-kibana kenl-kafka-broker kenl-kafka-broker2 kenl-nginx ) 
hosts_file="/tmp/hosts"

for data in ${hosts[@]}  
do  
    if [ `grep -c ${data} ${hosts_file}` -eq '0' ]; then
        echo "create $host_ip ${data} to ${hosts_file}"
        echo "$host_ip ${data}" >> ${hosts_file}
    fi
done 
