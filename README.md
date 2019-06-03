# docker-web 使用

www目录为对应代码目录，最新版php：php-7.3，nginx版本：1.16，同时支持php-5.6

## build php镜像

php-7.3-alpine 不支持 pgsql pdo_pgsql 扩展，但是要比 php-7.3 小接近200m

``` php
$ cd php-7.*
$ ./build.sh
```

## 运行docker-compose

``` php
$ sudo docker-compose up
或者
$ ./run.sh
```

## 相关配置

> 可以通过修改一下配置，然后通过volumes挂载生效，比如需要display error，可以修改php.ini中 display_errors = On

- php配置 php/conf/php.ini
- php-fpm配置 php/conf/php-fpm.conf
- nginx相关配置 nginx/www.conf

### 附 PHP Modules

``` php
Core
ctype
curl
date
dom
exif
fileinfo
filter
ftp
gd
hash
iconv
json
libxml
mbstring
memcached
mysqli
mysqlnd
openssl
pcntl
pcre
PDO
pdo_mysql
pdo_pgsql
pdo_sqlite
pgsql
Phar
posix
readline
redis
Reflection
session
SimpleXML
sockets
sodium
SPL
sqlite3
standard
tokenizer
xml
xmlreader
xmlwriter
Zend OPcache
zip
zlib

```