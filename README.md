# kenl

dockerized gateway service for data push processing


## 如何使用

安装依赖环境：
- `docker` 
- `docker-compose`

(可选) 下载基本docker镜像

```
$ cd bin/ && sh build-images.sh
```

执行后，检测相关镜像是否完成下载

```
$ docker images

REPOSITORY                                      TAG                 IMAGE ID            CREATED             SIZE
docker.io/domacli/kenl-nginx                    0.0.1               c736376ece66        About an hour ago   394.5 MB
docker.io/domacli/kenl-zookeeper                0.0.1               0b4d35b55338        2 hours ago         529.8 MB
docker.io/domacli/kenl-kafka-broker             0.0.1               cbc6e11bb9e0        2 hours ago         529.8 MB
docker.io/domacli/kenl-kafka-base               0.0.1               c85c5f3814af        3 hours ago         529.8 MB
docker.io/domacli/kenl-base                     0.0.1               94c1852db1ce        41 hours ago        287.8 MB
docker.elastic.co/logstash/logstash             6.3.1               4647f67650d3        3 months ago        657.4 MB
docker.elastic.co/kibana/kibana                 6.3.1               0bd7a7ea04f0        3 months ago        729.1 MB
docker.elastic.co/elasticsearch/elasticsearch   6.3.1               fa7212eab151        3 months ago        783.5 MB
docker.io/phusion/baseimage                     0.10.1              2391dfad8777        6 months ago        240.7 MB
```

执行安装脚本

```
$ cd bin/ && sh kenl-install.sh
```

es监控dashboard

浏览器访问：http://ip:9000

![cerebro](http://og0usnhfv.bkt.clouddn.com/cerebro.png)

浏览器访问：http://ip:24080

![kibana](http://og0usnhfv.bkt.clouddn.com/kibana.png)