FROM node:10-alpine
LABEL maintainer="viken2011@gmail.com"

WORKDIR /app
RUN apk --no-cache --virtual build-dependencies add \
    python \
    make \
    g++ \
    && npm install -g node-gyp node-pre-gyp --registry=https://registry.npm.taobao.org/ \
    && npm install -g grpc --unsafe-perm --grpc_node_binary_host_mirror=https://npm.taobao.org/mirrors/grpc/v1.24.2/node-v64-linux-x64-glibc.tar.gz --registry=https://registry.npm.taobao.org/ \
    && npm install -g etcd3 --unsafe-perm --registry=https://registry.npm.taobao.org/ \
    && npm uninstall -g node-gyp node-pre-gyp \
    && rm -rf /usr/local/lib/node_modules/grpc/build \
    && apk del build-dependencies
