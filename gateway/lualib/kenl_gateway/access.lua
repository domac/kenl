local _util = require "kenl_gateway.util"

local _cjson = require("cjson.safe")  
local json_encode = _cjson.encode  

local logger = ngx.log
local ERR = ngx.ERR    

local get_post_data=_util.get_post_data

local pushlog = get_post_data()

ngx.ctx.messageList = pushlog