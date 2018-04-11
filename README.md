# docker-web 使用

> www目录为对应代码目录

## build php镜像

``` php
$ cd php
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