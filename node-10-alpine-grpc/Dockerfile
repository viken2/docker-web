FROM node:10-alpine
LABEL maintainer="viken2011@gmail.com"

WORKDIR /app
RUN echo http://mirrors.aliyun.com/alpine/latest-stable/main > /etc/apk/repositories \
    && echo http://mirrors.aliyun.com/alpine/latest-stable/community >> /etc/apk/repositories \
    && apk --update upgrade \
    && apk --no-cache --virtual .build-deps add curl tzdata \
    python \
    make \
    g++ \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && npm install -g grpc@1.24.2 --unsafe-perm --registry=https://registry.npm.taobao.org/ \
    && rm -rf /usr/local/lib/node_modules/grpc/build \
    && apk del .build-deps
