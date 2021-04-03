# Si le dossier /var/run/nginx n'existe pas creer le dossier sinon lance php et le deamon nginx
if [[ ! -d /var/run/nginx ]]; then
	mkdir -p /var/run/nginx
fi
	php-fpm7 & nginx -g "daemon off;"