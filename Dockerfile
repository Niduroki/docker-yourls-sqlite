FROM yourls:1.8-apache

COPY ./yourls-sqlite/db.php /var/www/html/user/db.php

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["apache2-foreground"]
