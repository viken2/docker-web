FROM php:7.2-fpm-alpine
LABEL maintainer="viken2011@gmail.com"

COPY ./ext/*.tgz /tmp/ext/
RUN echo http://mirrors.aliyun.com/alpine/latest-stable/main > /etc/apk/repositories \
    && echo http://mirrors.aliyun.com/alpine/latest-stable/community >> /etc/apk/repositories \
    && apk --update upgrade \
    && apk add --no-cache --virtual .build-deps \
        curl autoconf automake make gcc g++ re2c \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libwebp-dev \
        libxml2-dev \
        libzip-dev \
        cyrus-sasl-dev \
        libmemcached-dev \
        postgresql-dev \
        linux-headers \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install zip \
    && docker-php-ext-install mysqli pdo_mysql pgsql pdo_pgsql exif pcntl sockets \
    && pecl install /tmp/ext/redis-5.1.1.tgz && docker-php-ext-enable redis \
    && pecl install /tmp/ext/grpc-1.28.0.tgz\
    && pecl install /tmp/ext/memcached-3.1.4.tgz \
    && pecl install /tmp/ext/xdebug-2.8.0.tgz \
    && cd / \
    && runDeps="$( \
        scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
            | tr ',' '\n' \
            | sort -u \
            | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )" \
    && apk add --no-cache $runDeps \
    && apk del --no-network .build-deps \
    && rm -rf /tmp/ext && rm -rf /tmp/pear

RUN apk add --no-cache gnu-libiconv
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php
