FROM php:5.6-fpm-alpine
LABEL maintainer="viken2011@gmail.com"

COPY ./ext/*.tgz /tmp/ext/
RUN echo http://mirrors.aliyun.com/alpine/latest-stable/main > /etc/apk/repositories \
    && echo http://mirrors.aliyun.com/alpine/latest-stable/community >> /etc/apk/repositories \
    && apk --update upgrade \
    && apk add --no-cache --virtual .build-deps \
        autoconf automake make gcc g++ \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libwebp-dev \
        libmcrypt-dev \
        libpng-dev \
        libmemcached-dev \
        libxml2-dev \
        libzip-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install zip \
    && docker-php-ext-install mysql mysqli pdo_mysql exif pcntl sockets \
    && pecl install /tmp/ext/memcached-2.2.0.tgz \
    && pecl install /tmp/ext/redis-2.2.8.tgz \
    && pecl install /tmp/ext/xdebug-2.5.5.tgz \
    && rm -rf /tmp/ext && rm -rf /tmp/pear
COPY ./conf/php.ini /usr/local/etc/php/conf.d/docker-php.ini
COPY ./conf/php-fpm.conf /usr/local/etc/php-fpm.d/www.conf
