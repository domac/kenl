
_Config = {

    TOPIC = "es-demo",

    BROKER_LIST = {
        { host = "172.17.0.3", port = 9092 }
    },

    KAFKA_CONFIG= {
        producer_type = "async", 
        socket_timeout = 6000,
        max_retry = 2,
        refresh_interval = 600 * 1000,
        keepalive_timeout = 600 * 1000,
        keepalive_size = 40,
        max_buffering = 1000000,
        flush_time = 100,
        batch_num = 500
    }
}

return _Config