FROM php:5.6-apache

RUN apt-get update

# PHP Extensions
RUN apt-get install -y --no-install-recommends \
    libmagickwand-6.q16-dev \
    libmcrypt-dev

RUN docker-php-ext-install \
    pdo_mysql \
    mcrypt \
    mbstring

RUN ln -s /usr/lib/x86_64-linux-gnu/ImageMagick-6.8.9/bin-Q16/MagickWand-config /usr/bin \
    && pecl install imagick \
    && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini

# Composer
ENV COMPOSER_VERSION 1.0.0-alpha11
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION}

# Apache
COPY ./apache2.conf /etc/apache2/apache2.conf

# App
WORKDIR /var/www

COPY composer.json /var/www/
RUN composer install

COPY . /var/www/