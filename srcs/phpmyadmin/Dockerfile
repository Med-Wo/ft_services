FROM alpine:latest

# Indique le createur et diverses informations concernant le container
LABEL maintainer="mravily@student.42.fr"
LABEL version="v0.2"
LABEL description="Container run on Alpine Linux for phpMyAdmin used like service pod Kubernetes"


# Mise à jour de l'index des paquets disponibles 
RUN apk update
# Install le package OPENSSL pour le generation du certificat SSL
RUN apk add openssl

# Telecharge et installe les different package necessaire a PhpMyAdmin
RUN apk add nginx wget php7 php7-fpm php7-mysqli php7-mbstring php7-json php7-session

# Telecharge le l'archive du code source de phpmyAdmin
RUN wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.4-all-languages.tar.gz

# Decompress l'archive
RUN tar -zxvf phpMyAdmin-5.0.4-all-languages.tar.gz

# Supprime l'archive
RUN rm -rf phpMyAdmin-5.0.4-all-languages.tar.gz

# Commande OpenSSL pour générer une clef privée et un certificat auto-signé pour notre webservice(nginx).
    # Pour commencer on utilise le gestionnaires des demandes de certificats X.509 avec une duree de vie de 90 jours 
    # On indique le nom de sortie du certificat
    # On indique le nom de sortie de la cle privee
    # On indique le format de notre nouvelle cle prive type:bits
    # On ne pas crypter la clé de sortie avec -nodes
    # on condense le message en SHA-256
    # et pour finir on defini des informations pour notre certifcats (Pays, Ville, Organisation et Nom)
RUN openssl req -x509 -days 90 \
    -out /etc/ssl/certs/phpMyAdmin.crt \
    -keyout /etc/ssl/phpMyAdmin.key \
    -newkey rsa:4096 -nodes -sha256 \
    -subj '/ST=France/L=Paris/O=42/CN=phpMyAdmin'

# Deplace les fichiers sources phpMyAddmin
RUN mv phpMyAdmin-5.0.4-all-languages /var/www/phpmyadmin

# Copie les fichiers dans le container
COPY /srcs/start_service.sh /
COPY /srcs/config.inc.php /var/www/phpmyadmin/
COPY /srcs/nginx.conf /etc/nginx/

# Creer un dossier /tmp pour phpmyadmin
RUN mkdir -p /var/www/phpmyadmin/tmp

#Expose les ports 5000 et 80 du container
EXPOSE 5000 80

ENTRYPOINT ["sh", "start_service.sh"]
