FROM php:5.6-apache

RUN a2enmod rewrite

# install the PHP extensions we need
RUN apt-get update && apt-get install -y wget libpng12-dev libjpeg-dev  libtidy-dev \ 
    && rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install tidy \ 
    && docker-php-ext-install opcache
    
RUN pecl install zip memcache apc

RUN a2enmod headers
RUN a2enmod expires

RUN cd /usr/local/src && wget http://pecl.php.net/get/APC-3.1.9.tgz && tar -xzf APC-3.1.9.tgz && cd APC-3.1.9

VOLUME /var/www/html

ENV WORDPRESS_VERSION 4.2.4
ENV WORDPRESS_SHA1 9c90d175e0e64f51681101058a820cd76475949a

# upstream tarballs include ./wordpress/ so this gives us /usr/src/wordpress
RUN curl -o wordpress.tar.gz -SL https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz \
	&& echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c - \
	&& tar -xzf wordpress.tar.gz -C /usr/src/ \
	&& rm wordpress.tar.gz \
	&& chown -R www-data:www-data /usr/src/wordpress

COPY config/php.ini /usr/local/etc/php/php.ini	

COPY docker-entrypoint.sh /entrypoint.sh

# Install mod-pagespeed
RUN wget https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb \
   && dpkg -i mod-pagespeed-*.deb \ 
   && apt-get -f install \
   && rm mod-pagespeed-*.deb

# ENTRYPOINT resets CMD now
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
