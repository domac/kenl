# kenl

dockerized gateway service for data push processing


## 如何使用

安装依赖环境：
- `docker` 
- `docker-compose`

(可选) 下载基本docker镜像

```
$ cd bin/ && sh build-images.sh
```

执行后，检测相关镜像是否完成下载

```
$ docker images

REPOSITORY                                      TAG                 IMAGE ID            CREATED             SIZE
docker.io/domacli/kenl-nginx                    0.0.1               c736376ece66        5 hours ago         394.5 MB
docker.io/domacli/kenl-zookeeper                0.0.1               0b4d35b55338        6 hours ago         529.8 MB
docker.io/domacli/kenl-kafka-broker             0.0.1               cbc6e11bb9e0        6 hours ago         529.8 MB
docker.io/domacli/kenl-kafka-base               0.0.1               c85c5f3814af        7 hours ago         529.8 MB
docker.io/domacli/kenl-base                     0.0.1               94c1852db1ce        45 hours ago        287.8 MB
docker.io/yannart/cerebro                       0.8.1               a430c915d3ae        3 months ago        505.3 MB
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


## gateway部署

### 安装openresty
    
安装依赖包  
``` 
$ yum install -y gcc gcc-c++ readline-devel pcre-devel openssl-devel tcl perl zlib zlib-devel
```  
   
    
安装openresty

```
$ tar zxvf ngx_openresty-1.13.6.2.tar.gz    
$ cd ngx_openresty-1.13.6.2

$ ./configure \
   --prefix=/usr/local/openresty \
   --with-cc-opt="-I/usr/local/opt/openssl/include/ -I/usr/local/opt/pcre/include/" \
   --with-ld-opt="-L/usr/local/opt/openssl/lib/ -L/usr/local/opt/pcre/lib/" \
   -j8

$ gmake    
$ gmake install

$ ln -sfnv /usr/local/openresty/nginx/sbin/nginx /usr/local/bin/nginx
```

### 部署gateway

```
$ cd bin/ && sh gateway-install.sh
```

### 依赖

[lua-resty-kafka](https://github.com/doujiang24/lua-resty-kafka)

