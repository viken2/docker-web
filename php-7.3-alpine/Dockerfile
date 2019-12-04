FROM php:7.3-fpm-alpine
LABEL maintainer="viken2011@gmail.com"

WORKDIR /data/www
COPY ./ext/*.tgz /tmp/ext/
RUN echo http://mirrors.aliyun.com/alpine/latest-stable/main > /etc/apk/repositories \
    && echo http://mirrors.aliyun.com/alpine/latest-stable/community >> /etc/apk/repositories \
    && apk --update upgrade && apk add curl tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del tzdata \
    && apk add --no-cache --virtual .build-deps \
        autoconf automake make gcc g++ \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libwebp-dev \
        libmemcached-dev \
        libxml2-dev \
        libzip-dev \
        postgresql-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install zip \
    && docker-php-ext-install mysqli pdo_mysql pgsql pdo_pgsql exif pcntl sockets \
    && pecl install /tmp/ext/memcached-3.1.4.tgz \
    && pecl install /tmp/ext/redis-5.1.1.tgz \
    && pecl install /tmp/ext/xdebug-2.8.0.tgz \
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
COPY ./conf/php.ini /usr/local/etc/php/conf.d/docker-php.ini
COPY ./conf/php-fpm.conf /usr/local/etc/php-fpm.d/www.conf
