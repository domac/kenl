local _config = require "kenl_gateway.config"
local _producer = require "resty.kafka.producer" 


local logger = ngx.log
local ERR = ngx.ERR

local BROKER_LIST = _config.BROKER_LIST
local KAFKA_CONFIG = _config.KAFKA_CONFIG
local topic = _config.TOPIC


local local_producer

local function send_kafka(topic, message)
    if not local_producer then
        local_producer = _producer:new(BROKER_LIST, KAFKA_CONFIG)
    end

    if message then
        local ok, err = local_producer:send(topic, nil, message)
        if not ok  then
            return nil, err
        end
        return ok, nil
    end
    return false, "message empty"
end


local data = ngx.ctx.messageList 

local ok, err = send_kafka(topic,data)

if not ok then
    ngx.log(ngx.ERR, "failed to log message to:", err)
end
