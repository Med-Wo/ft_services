if [[ ! -d /var/run/nginx ]]; then
	mkdir -p /var/run/nginx
fi
	php-fpm7 & nginx -g "daemon off;"