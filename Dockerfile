FROM nerdsandcompany/php-base
MAINTAINER Arjan Kleene <a.kleene@nerds.company>

# Copy dep files first so Docker caches the install step if they don't change
ONBUILD COPY composer.lock /var/www/html/
ONBUILD COPY composer.json /var/www/html/
ONBUILD ADD . /var/www/html/

# Run composer install
ONBUILD RUN composer install --prefer-source --no-interaction
