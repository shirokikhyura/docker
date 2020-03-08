#!/bin/bash
usermod -u "$UID_VAR" www-data
groupmod -g "$GID_VAR" www-data
chown -R www-data:www-data /var/www

/usr/bin/php-fpm