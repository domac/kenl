
_Config = {

    TOPIC = "edrlog",

    BROKER_LIST = {
        { host = "kenl-kafka-broker", port = 9092 },
        { host = "kenl-kafka-broker2", port = 9093 },
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