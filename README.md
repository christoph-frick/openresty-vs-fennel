# [SOLVED] Failing example: fennel in openresty

## Solution

OpenResty want's to protect the globals so no code run per reqest can mess with it.

To restore the global state use the following before requiring fennel

```lua
_G = getmetatable(_G)["__index"] -- XXX
local fennel = require("fennel")
```

## Error

```
openresty_1  | 2018/11/13 21:24:59 [error] 8#8: *1 lua entry thread aborted: runtime error: Compile error in 'ipairs' unknown:3: unknown global in strict mode: ipairs
openresty_1  | stack traceback:
openresty_1  | coroutine 0:
openresty_1  |  [C]: in function 'require'
openresty_1  |  content_by_lua(default.conf:9):2: in function <content_by_lua(default.conf:9):1>, client: 172.22.0.1, server: , request: "GET / HTTP/1.1", host: "localhost:8080"
openresty_1  | 172.22.0.1 - - [13/Nov/2018:21:24:59 +0000] "GET / HTTP/1.1" 500 199 "-" "curl/7.61.0"
```

## Steps to reproduce

Start container:

```sh
docker-compose up --build
```

Fetch site

```
curl localhost:8080
```

Error see above:

```
Compile error in 'ipairs' unknown:3: unknown global in strict mode: ipairs
```
