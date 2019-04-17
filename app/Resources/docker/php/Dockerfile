FROM php:7.2-fpm

RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y

RUN apt-get install -y \
    git \
    zip

RUN apt-get install -y \
    libcurl4-openssl-dev \
    libxml2-dev \
    libgd-dev \
    libicu-dev \
    libzip-dev \
    libbz2-dev \
    libyaml-dev \
    libmagickwand-dev \
    libmemcached-dev

RUN docker-php-ext-install \
    bcmath \
    bz2 \
    curl \
    dom \
    exif \
    fileinfo \
    gettext \
    gd \
    iconv \
    intl \
    mbstring \
    mysqli \
    opcache \
    pdo \
    pdo_mysql \
    simplexml \
    zip

RUN yes "" | pecl install \
    apcu \
    memcached \
    imagick \
    redis

RUN docker-php-ext-enable \
    bcmath \
    bz2 \
    curl \
    dom \
    exif \
    fileinfo \
    gettext \
    gd \
    iconv \
    intl \
    mbstring \
    mysqli \
    opcache \
    pdo \
    pdo_mysql \
    simplexml \
    zip \
    apcu \
    memcached \
    imagick \
    redis

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY ./*.ini /usr/local/etc/php/conf.d/