local json = require("cjson") 

local _json_encode = json.encode

local _result = {
    ret_code = 0
}

local text = _json_encode(_result)
ngx.say(text)