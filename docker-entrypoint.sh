#!/bin/bash
set -euo pipefail

if [ ! -e /var/www/html/yourls-loader.php ]; then
	tar cf - --one-file-system -C /usr/src/yourls . | tar xf -
	chown -R www-data:www-data /var/www/html
fi

if [[ "$1" == apache2* ]] || [ "$1" == php-fpm ]; then
	if [ "$(id -u)" = '0' ]; then
		# if not specified, let's generate a random value
		: "${YOURLS_COOKIEKEY:=$(head -c1m /dev/urandom | sha1sum | cut -d' ' -f1)}"

		# We want to copy the initial config if the actual config file doesn't already
		# exist OR if it is an empty file (e.g. it has been created for the volume mount).
		if [ ! -e /var/www/html/user/config.php ] || [ ! -s /var/www/html/user/config.php ]; then
			cp /var/www/html/user/config-docker.php /var/www/html/user/config.php
			chown www-data:www-data /var/www/html/user/config.php
		fi

		: "${YOURLS_USER:=}"
		: "${YOURLS_PASS:=}"
		if [ -n "${YOURLS_USER}" ] && [ -n "${YOURLS_PASS}" ]; then
			result=$(sed "s/  getenv('YOURLS_USER') => getenv('YOURLS_PASS'),/  \'${YOURLS_USER}\' => \'${YOURLS_PASS}\',/g" /var/www/html/user/config.php)
			echo "$result" > /var/www/html/user/config.php
		fi

		# Set default db name
		: "${YOURLS_DB_NAME:="yourls"}"
		# If YOURLS_DB_NAME doesn't start with sqlite/ we'll prepend it, in order to write into the sqlite-volume
		if [[ $YOURLS_DB_NAME != "sqlite/"* ]]; then
			YOURLS_DB_NAME="sqlite\/"$YOURLS_DB_NAME
		fi

		result=$(sed "s/define( 'YOURLS_DB_NAME', getenv_docker('YOURLS_DB_NAME', 'yourls') );/define( 'YOURLS_DB_NAME', \'$YOURLS_DB_NAME\' );/g" /var/www/html/user/config.php)
		echo "$result" > /var/www/html/user/config.php

		# We'd create the DB here if it doesn't exist "just to be safe" - For SQLite we can't do that.
		#TERM=dumb php -- [[[SNIP]]]
		# Source: https://github.com/YOURLS/docker-yourls/blob/cb2549780e6f062993c136d4da74b8463f269534/docker-entrypoint.sh
	fi
fi

exec "$@"
