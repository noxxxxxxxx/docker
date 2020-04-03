FROM nginx:alpine AS builder

# nginx:alpine contains NGINX_VERSION environment variable, like so:
# ENV NGINX_VERSION 1.17.9

# Our NGX_HTTP_ECHO_MODULE version
ENV NGX_HTTP_ECHO_MODULE_VERSION 0.62rc1

# If download slowly you can choose other source
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories

# Download sources
RUN wget "http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz" -O nginx.tar.gz && \
  wget "https://github.com/openresty/echo-nginx-module/archive/v${NGX_HTTP_ECHO_MODULE_VERSION}.tar.gz" -O echo.tar.gz

# For latest build deps, see https://github.com/nginxinc/docker-nginx/blob/master/mainline/alpine/Dockerfile
RUN apk add --no-cache --virtual .build-deps \
  gcc \
  libc-dev \
  make \
  openssl-dev \
  pcre-dev \
  zlib-dev \
  linux-headers \
  curl \
  gnupg \
  libxslt-dev \
  gd-dev \
  geoip-dev

# Reuse same cli arguments as the nginx:alpine image used to build
RUN CONFARGS=$(nginx -V 2>&1 | sed -n -e 's/^.*arguments: //p') \
	tar -zxC /usr/src -f nginx.tar.gz && \
  tar -xzvf "echo.tar.gz" && \
  ECHODIR="$(pwd)/echo-${NGX_HTTP_ECHO_MODULE_VERSION}" && \
  cd /usr/src/nginx-$NGINX_VERSION && \
  ./configure --with-compat $CONFARGS --add-dynamic-module=$ECHODIR && \
  make && make install

FROM nginx:alpine
# Extract the dynamic module NCHAN from the builder image
COPY --from=builder /usr/local/nginx/modules/ngx_http_echo_module.so /usr/local/nginx/modules/ngx_http_echo_module.so
# RUN rm /etc/nginx/conf.d/default.conf

# COPY nginx.conf /etc/nginx/nginx.conf
# COPY default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
USER www-data
STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]