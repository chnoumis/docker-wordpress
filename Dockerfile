FROM wordpress:latest

# Add php.ini
COPY php.ini /usr/local/etc/php

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
