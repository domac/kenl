docker build -t domacli/kenl-postgresql:0.0.1 .

docker run --name postgresql -itd --restart always --publish 25432:25432 --volume /data/kenl/postgresql:/var/lib/postgresql --env 'REPLICATION_PORT=25432' domacli/kenl-postgresql:0.0.1