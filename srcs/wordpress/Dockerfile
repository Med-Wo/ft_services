FROM alpine:latest

# Indique le createur du conteneur
LABEL maintainer="mravily@student.42.fr"
LABEL version="v1.5"
LABEL description="Container run on Alpine Linux for phpmyadmin used like service pod Kubernetes"

# Update les packages present de bases sous Alpine
RUN     apk update

# Install OPENSSL pour la generation de cle et de certificat SSL
RUN     apk add openssl

# Install le package nginx
RUN     apk add nginx

# Install les packages pour PHP
RUN     apk add php7-fpm php7-mcrypt php7-soap \
			    php7-openssl php7-gmp php7-pdo_odbc \
				php7-json php7-dom php7-pdo php7-zip \
				php7-mysqli php7-sqlite3 php7-apcu \
				php7-pdo_pgsql php7-bcmath php7-gd \
				php7-odbc php7-pdo_mysql php7-pdo_sqlite \
				php7-gettext php7-xmlreader php7-xmlrpc \
				php7-bz2 php7-iconv php7-pdo_dblib php7-curl \
				php7-ctype

# Telechargement de Wordpress
RUN		wget https://www.wordpress.org/latest.tar.gz \
			&& tar -xf latest.tar.gz \
			&& rm -rf latest.tar.gz

# Deplacement des fichiers wordpress     
RUN     mv wordpress /var/www/wordpress

# Copie des fichiers de configuration dans le container
COPY    /srcs/start_service.sh      /
COPY    /srcs/wp-config.php         /var/www/wordpress/
COPY    /srcs/nginx.conf            /etc/nginx/

ENTRYPOINT ["sh", "start_service.sh"]