FROM php:7.3-fpm-alpine
LABEL maintainer="viken2011@gmail.com"

WORKDIR /data/www
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk --update upgrade \
    && apk add --no-cache --virtual .build-deps \
        tzdata ca-certificates gnu-libiconv \
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
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install zip \
    && docker-php-ext-install mysqli pdo_mysql pgsql pdo_pgsql exif pcntl sockets \
    && pecl install memcached \
    && pecl install redis \
    && pecl install xdebug \
    && cd /usr/local/etc/php && cp php.ini-production php.ini \
    && cd / \
    && runDeps="$( \
        scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
            | tr ',' '\n' \
            | sort -u \
            | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )" \
    && apk add --no-cache $runDeps \
    && apk del --no-network .build-deps \
    && rm -rf /tmp/*

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

COPY ./conf/php.ini /usr/local/etc/php/conf.d/docker-php.ini
COPY ./conf/php-fpm.conf /usr/local/etc/php-fpm.d/www.conf
