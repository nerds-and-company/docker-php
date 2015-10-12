FROM php:5.6-apache

# update apt
RUN apt-get update

# Install mcrypt
RUN apt-get install -y libmcrypt4 libmcrypt-dev \
 && docker-php-ext-install mcrypt

# Install gd
RUN apt-get install -y libfreetype6-dev libjpeg-dev libpng12-dev --no-install-recommends \
 && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
 && docker-php-ext-install gd

# Install other needed extensions
RUN docker-php-ext-install mbstring pdo_mysql

# Enable mod_rewrite
RUN a2enmod rewrite

# Install mysql client
RUN apt-get install -y mysql-client

# Install redis tools
RUN apt-get install -y redis-tools

# Install Composer (same as Heroku uses)
RUN curl --silent --location "https://lang-php.s3.amazonaws.com/dist-cedar-14-master/composer.tar.gz?version=1.0.0-alpha10" | tar xz -C /app/.heroku/php

# Copy dep files first so Docker caches the install step if they don't change
ONBUILD COPY composer.lock /var/www/html/
ONBUILD COPY composer.json /var/www/html/
ONBUILD ADD . /var/www/html/

# Run composer install
ONBUILD RUN composer install

# Change PATH to include composer bin files
ENV PATH vendor/bin:$PATH
