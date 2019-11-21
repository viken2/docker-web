FROM php:7.3-fpm
LABEL maintainer="viken2011@gmail.com"

COPY ./sources.list /etc/apt/sources.list
COPY ./ext/*.tgz /tmp/ext/
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \ 
    && dpkg-reconfigure -f noninteractive tzdata \
    && apt-get update && apt-get -y upgrade && apt-get install -y procps net-tools \
    && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libmemcached-dev \
        libxml2-dev \
        libzip-dev \
        libpq-dev \
    && rm -r /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install zip \
    && docker-php-ext-install mysqli pdo_mysql pgsql pdo_pgsql exif pcntl sockets \
    && pecl install /tmp/ext/memcached-3.1.3.tgz \
    && pecl install /tmp/ext/redis-4.3.0.tgz \
    && pecl install /tmp/ext/xdebug-2.7.2.tgz \
    && rm -rf /tmp/ext && rm -rf /tmp/pear
COPY ./conf/php.ini /usr/local/etc/php/conf.d/docker-php.ini
COPY ./conf/php-fpm.conf /usr/local/etc/php-fpm.d/www.conf
