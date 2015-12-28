FROM php:5.6-fpm

# PHP Extensions
RUN docker-php-ext-install mbstring pdo_mysql
RUN apt-get update && apt-get install -y libmagickwand-6.q16-dev --no-install-recommends \
    && ln -s /usr/lib/x86_64-linux-gnu/ImageMagick-6.8.9/bin-Q16/MagickWand-config /usr/bin \
    && pecl install imagick \
    && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini

# Composer
ENV COMPOSER_VERSION 1.0.0-alpha11
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION}

# App
RUN mkdir /app
WORKDIR /app

COPY composer.json /app/
RUN composer install

COPY . /app/