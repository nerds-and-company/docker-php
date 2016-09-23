# nerdsandcompany/php
Nerds and Company PHP image for Docker
This container extends the `nerdsandcompany/php-base` container. See for more information that container.

## Usage

Make sure you add the following lines to your project's Dockerfile:
```
FROM nerdsandcompany/php

# Run composer install if composer.json is present
COPY composer.json /var/www/html/
COPY composer.lock /var/www/html/
RUN [ ! -e composer.json ] || composer install --prefer-source --no-interaction

# Copy dep files first so Docker caches the install step if they don't change
ADD . /var/www/html/
```

## See also
- [`nerdsandcompany/php-base`](https://github.com/nerds-and-company/docker-php-base)

## License
[MIT](LICENSE)
