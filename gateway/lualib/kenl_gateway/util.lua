local _Util = {}

function _Util.get_post_data()
    local args = {}
    local request_method = ngx.var.request_method
    -- get post data
    if "POST" == request_method then
        ngx.req.read_body()
        args = ngx.req.get_body_data()
    end

    return args
end

function _Util.get_remote_ip()
    local ip = ngx.req.get_headers()["X-Real-IP"]
    if not ip then
        ip = ngx.req.get_headers()["x_forwarded_for"]
    end
    if not ip then
        ip = ngx.var.remote_addr
    end
    return ip
end

return _Util


function _Util.get_args()
    local args = {}
    local request_method = ngx.var.request_method
    if "GET" == request_method then
        args = ngx.req.get_uri_args()
    elseif "POST" == request_method then
        ngx.req.read_body()
        args = ngx.req.get_post_args()
    end
    return args
end

function _Util.request_time()
    local ngx_time = ngx.time();
    local server_time=os.date("%Y-%m-%d %H:%M:%S",ngx_time);
    return server_time;
end