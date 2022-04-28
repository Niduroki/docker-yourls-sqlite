FROM yourls:1.9-apache

COPY ./yourls-sqlite/db.php /var/www/html/user/db.php

RUN mkdir /var/www/html/user/sqlite
VOLUME ["/var/www/html/user/sqlite"]

CMD ["apache2-foreground"]
