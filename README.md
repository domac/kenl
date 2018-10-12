# kenl

dockerized gateway service for data push processing

简单组件架构如下：

![edr](http://og0usnhfv.bkt.clouddn.com/edr.png)

## 如何使用

安装依赖环境：
- `docker` 
- `docker-compose`

(可选) 下载基本docker镜像

```sh
$ cd bin/ && sh build-images.sh
```

执行后，检测相关镜像是否完成下载

```sh
$ docker images

REPOSITORY                                      TAG                 IMAGE ID            CREATED             SIZE
docker.io/domacli/kenl-spark-worker             0.0.1               3e357a046e96        11 minutes ago      979.2 MB
docker.io/domacli/kenl-spark-master             0.0.1               bfcee358651c        14 minutes ago      979.2 MB
docker.io/domacli/kenl-spark-base               0.0.1               bd0d99ad769c        2 hours ago         979.2 MB
docker.io/domacli/kenl-nginx                    0.0.1               c736376ece66        27 hours ago        394.5 MB
docker.io/domacli/kenl-zookeeper                0.0.1               0b4d35b55338        28 hours ago        529.8 MB
docker.io/domacli/kenl-kafka-broker             0.0.1               cbc6e11bb9e0        29 hours ago        529.8 MB
docker.io/domacli/kenl-kafka-base               0.0.1               c85c5f3814af        30 hours ago        529.8 MB
docker.io/domacli/kenl-base                     0.0.1               94c1852db1ce        2 days ago          287.8 MB
docker.io/yannart/cerebro                       0.8.1               a430c915d3ae        3 months ago        505.3 MB
docker.elastic.co/logstash/logstash             6.3.1               4647f67650d3        3 months ago        657.4 MB
docker.elastic.co/kibana/kibana                 6.3.1               0bd7a7ea04f0        3 months ago        729.1 MB
docker.elastic.co/elasticsearch/elasticsearch   6.3.1               fa7212eab151        3 months ago        783.5 MB
ddocker.io/omacli/jupyter                       0.0.1               7703f00297f9        21 minutes ago      2.18GB
docker.io/phusion/baseimage                     0.10.1              2391dfad8777        6 months ago        240.7 MB
```

执行安装脚本

```sh
$ cd bin/ && sh kenl-install.sh
```

## gateway部署

### 安装openresty
    
安装依赖包  

```sh 
$ yum install -y gcc gcc-c++ readline-devel pcre-devel openssl-devel tcl perl zlib zlib-devel
```  
   
    
安装openresty

```sh
$ tar zxvf ngx_openresty-1.13.6.2.tar.gz    
$ cd ngx_openresty-1.13.6.2

$ ./configure \
   --prefix=/usr/local/openresty \
   --with-cc-opt="-I/usr/local/opt/openssl/include/ -I/usr/local/opt/pcre/include/" \
   --with-ld-opt="-L/usr/local/opt/openssl/lib/ -L/usr/local/opt/pcre/lib/" \
   -j8

$ gmake    
$ gmake install
```


```sh
$ ln -sfnv /usr/local/openresty/nginx/sbin/nginx /usr/local/bin/nginx
```

### 部署gateway

```sh
$ cd bin/ && sh gateway-install.sh
```


## 数据上报：

演示格式：

> 报文格式字段的制定和过滤可以参照 docker/kenl-logstash/pipeline/12-kenl-edr-filter.conf，自己也可以设计自定义的报文格式，放到 docker/kenl-logstash/pipeline/ 下即可

```
{
	"client_ip": ["192.168.0.1", "192.168.0.2", "192.168.0.3"],
	"computer_name": "pc",
	"mid": "abc123",
	"cmds": [{
		"cmd": 50101,
		"time": "2018-09-20 12:02:30.453",
		"data": {
			"ProcessPath": "D:\\Program Files (X86)\\demo.exe",
			"ProcessMd5": "testmd5123",
			"ProcessId": 1024,
			"CommandLine": "xxx.bat",
			"Operation": "upload",
			"FilePath": "D:\\Program Files (X86)\\demo.exe",
			"FileMd5": "testmd5123"
		}
	}]
}
```
演示上报

```sh
curl -XPOST -H 'Content-Type: application/json' 'http://your-gateway:12080/push' -d '{"client_ip":["192.168.0.1","192.168.0.2","192.168.0.3"],"computer_name":"pc","mid":"abc123","cmds":[{"cmd":50101,"time":"2018-09-20 12:02:30.453","data":{"ProcessPath":"D:\\Program Files (X86)\\demo.exe","ProcessMd5":"testmd5123","ProcessId":1024,"CommandLine":"xxx.bat","Operation":"upload","FilePath":"D:\\Program Files (X86)\\demo.exe","FileMd5":"testmd5123"}}]}'
```

## 组件监控

#### es监控dashboard

浏览器访问：http://ip:9000

![cerebro](http://og0usnhfv.bkt.clouddn.com/cerebro.png)

#### kibana dashboard

浏览器访问：http://ip:24080

![kibana](http://og0usnhfv.bkt.clouddn.com/kibana2.png)


#### Jupyter Notebook

浏览器访问：http://ip:8000

![jupyter](http://og0usnhfv.bkt.clouddn.com/jupyter.png)


