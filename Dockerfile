FROM php:8.4-fpm-alpine

# Install system dependencies
RUN apk add --no-cache \
    icu-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    rabbitmq-c-dev \
    postgresql-dev \
    linux-headers

# Install PHP extensions
RUN docker-php-ext-install intl pdo pdo_pgsql zip

# Install and enable AMQP (for RabbitMQ) and Redis
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    && pecl install amqp redis \
    && docker-php-ext-enable amqp redis \
    && apk del .build-deps

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
