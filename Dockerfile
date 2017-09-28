FROM php:7-fpm-alpine

RUN apk add --update --no-cache --virtual .ext-deps \
        libjpeg-turbo-dev \
        libwebp-dev \
        libpng-dev \
        freetype-dev \
        libmcrypt-dev \
        autoconf \
        g++ \
        make

RUN \
    docker-php-ext-configure pdo_mysql && \
    docker-php-ext-configure opcache && \
    docker-php-ext-configure exif && \
    docker-php-ext-configure gd \
    --with-jpeg-dir=/usr/include --with-png-dir=/usr/include --with-webp-dir=/usr/include --with-freetype-dir=/usr/include && \
    docker-php-ext-configure sockets && \
    docker-php-ext-configure mcrypt && \
    docker-php-ext-install pdo_mysql opcache exif gd sockets mcrypt
    
RUN \
    pecl install redis && \
    pecl clear-cache && \
    docker-php-ext-enable redis.so && \
    docker-php-source delete