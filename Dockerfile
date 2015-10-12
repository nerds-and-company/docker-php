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
