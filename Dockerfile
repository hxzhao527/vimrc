FROM php:7.1.33-fpm
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && apt update &&\
    apt install -y curl git libwebp-dev libjpeg62-turbo-dev libpng-dev libxpm-dev libfreetype6-dev zlib1g-dev libzip-dev \
    libcurl4-openssl-dev libldap2-dev libxml2-dev libicu-dev libmcrypt-dev libzstd-dev libmemcached-dev
RUN docker-php-ext-install mysqli pdo pdo_mysql &&\
    docker-php-ext-install ctype mbstring zip bcmath curl ldap dom fileinfo intl hash mcrypt xml json iconv opcache session simplexml &&\
    docker-php-ext-configure gd --with-gd --with-webp-dir --with-jpeg-dir --with-png-dir --with-zlib-dir --with-xpm-dir --with-freetype-dir --enable-gd-native-ttf &&\
    docker-php-ext-install gd
RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini &&\
    pear config-set php_ini /usr/local/etc/php/php.ini && pecl config-set php_ini /usr/local/etc/php/php.ini &&\
    pecl install igbinary &&\
    pecl install yaf &&\
    pecl install protobuf &&\
    pecl install msgpack &&\
    pecl install uopz &&\
    pecl install xdebug &&\
    yes | pecl install apcu &&\
    yes | pecl install redis &&\
    docker-php-source extract &&\
    git clone --branch php7 https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached/ &&\
    docker-php-ext-install memcached &&\
    docker-php-source delete 
RUN useradd -s /bin/bash -m xiaoju &&\
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" &&\
    php composer-setup.php --version=1.4.1 && php -r "unlink('composer-setup.php');" &&\
    mv composer.phar /usr/local/bin/composer &&\
    composer config -g repo.packagist composer https://packagist.phpcomposer.com &&\
    sed -i 's,^\(MinProtocol[ ]*=\).*,\1'TLSv1.0',g' /etc/ssl/openssl.cnf && sed -i 's,^\(CipherString[ ]*=\).*,\1'DEFAULT@SECLEVEL=1',g' /etc/ssl/openssl.cnf 
USER xiaoju
