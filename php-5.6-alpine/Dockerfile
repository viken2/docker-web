FROM php:5.6-fpm-alpine
LABEL maintainer="viken2011@gmail.com"

WORKDIR /data/www
COPY ./ext/*.tgz /tmp/ext/
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk --update upgrade \
    && apk add --no-cache --virtual .build-deps \
        tzdata ca-certificates \
        curl autoconf automake make gcc g++ re2c \
        pcre-dev \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libwebp-dev \
        libmcrypt-dev \
        libpng-dev \
        libxml2-dev \
        libzip-dev \
        cyrus-sasl-dev \
        libmemcached-dev \
        postgresql-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install zip \
    && docker-php-ext-install mysql mysqli pdo_mysql pgsql pdo_pgsql exif pcntl sockets \
    && pecl install /tmp/ext/memcached-2.2.0.tgz \
    && pecl install /tmp/ext/redis-2.2.8.tgz \
    && pecl install /tmp/ext/xdebug-2.5.5.tgz \
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
    && rm -rf /tmp/ext && rm -rf /tmp/pear

# https://github.com/docker-library/php/issues/240#issuecomment-305038173
# php -d error_reporting=22527 -d display_errors=1 -r "var_dump(iconv('UTF-8//IGNORE', 'UTF-8', '哈哈哈')) . PHP_EOL;"
RUN apk add --no-cache --repository http://mirrors.aliyun.com/alpine/edge/community gnu-libiconv
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

COPY ./conf/php.ini /usr/local/etc/php/conf.d/docker-php.ini
COPY ./conf/php-fpm.conf /usr/local/etc/php-fpm.d/www.conf
