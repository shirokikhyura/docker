FROM phpdockerio/php71-fpm:latest

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

# Install selected extensions and other stuff
RUN apt-get update \
    && apt-get -y --no-install-recommends install php-memcached php7.1-dev php7.1-bcmath php7.1-common php7.1-mysql php-xdebug php7.1-gd php-imagick php7.1-imap php7.1-soap \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin
RUN export PATH="~/.composer/vendor/bin/:$PATH"

WORKDIR /var/www/runner

ADD entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

CMD ["entrypoint.sh"]