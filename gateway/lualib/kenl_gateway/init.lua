-- user : domac.li

local ERR = ngx.ERR
local logger = ngx.log

print("ready to init kenl_gateway")

-- load config
_config = require "kenl_gateway.config"

if not _config then
    logger(ERR, "load config error")
end