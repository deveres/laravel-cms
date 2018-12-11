# Image for registry gitlab

# Registry base image used postgres is installed for use psql
# Build and upload to gitlab
# docker login registry.gitlab.com
# docker build -t registry.gitlab.com/deveresgroup/laravel-admin.dev .
# docker push registry.gitlab.com/deveresgroup/laravel-admin.dev

# Connect
# docker run -i -t registry.gitlab.com/deveresgroup/laravel-admin.dev /bin/bash
# docker exec -it 7b547958a1e2  bash

# Set the base image for subsequent instructions
FROM php:7.1.20-apache-jessie

# Update packages
# Install PHP and composer dependencies
RUN   set -xe \
      && apt-get update -yqq \
      && apt-get install -yqq \
      wget \
      sudo \
      git \
      libmcrypt-dev \
      libcurl4-gnutls-dev \
      sendmail \
      libpng-dev  \
      libicu-dev \
      libpq-dev \
      libzip-dev \
      zlib1g-dev \
      libxml2-dev \
      libbz2-dev \
      libc-client-dev \
      libkrb5-dev \
      zip \
      unzip


# Clear out the local repository of retrieved package files
#RUN apt-get clean

# Install needed extensions
# Here you can install any other extension that you need during the test and deployment process
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
      && docker-php-ext-install \
         mcrypt \
         pdo_mysql \
         pdo_pgsql \
         pgsql \
         pdo \
         zip \
         mbstring \
         mcrypt \
         curl \
         soap \
         iconv \
         opcache \
         json \
         sockets \
         intl \
         gd \
         xml \
         bz2

ADD php.ini /usr/local/etc/php/conf.d/40-custom.ini

#install postgres
RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main' >> /etc/apt/sources.list.d/postgresql.list \
    && wget --no-check-certificate -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O- | apt-key add - \
    && apt-get update -yqq \
    && apt-get install postgresql-9.6 -y \
    && service postgresql start


# Install Composer
RUN curl --silent --show-error https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Laravel Envoy
RUN composer global require "laravel/envoy=~1.0"