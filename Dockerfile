FROM openresty/openresty:alpine

ADD files/fennel.lua /usr/local/openresty/lualib/
ADD files/default.conf /etc/nginx/conf.d/
ADD files/root.fnl /usr/local/www/
