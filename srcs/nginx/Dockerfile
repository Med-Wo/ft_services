FROM alpine:latest

# Indique le createur du conteneur
LABEL maintainer="mravily@student.42.fr"
LABEL version="v0.8"
LABEL description="Container run under Alpine Linux with Nginx used like service pod Kubernetes used as pod services by K8S"

# Mettre à jour l'index des packages disponibles 
RUN apk update

# Installe les differents package pour nginx
	# Installe le serveur nginx
RUN apk add nginx
	# Install OPENSSL pour le certificat SSL
RUN apk add openssl
	# Install OPENSSH pour le SSH
RUN apk add openssh

# Commande OpenSSL pour générer une clef privée et un certificat auto-signé pour notre webservice(nginx).
    # Pour commencer on utilise le gestionnaires des demandes de certificats X.509 avec une duree de vie de 90 jours 
    # On indique le nom de sortie du certificat
    # On indique le nom de sortie de la cle privee
    # On indique le format de notre nouvelle cle prive type:bits
    # On ne pas crypter la clé de sortie avec -nodes
    # on condense le message en SHA-256
    # et pour finir on defini des informations pour notre certifcats (Pays, Ville, Organisation et Nom)
RUN openssl req -x509 -days 90 \
            -out /etc/ssl/certs/webservice.crt \
            -keyout /etc/ssl/webservice.key \
            -newkey rsa:4096 -nodes -sha256 \
            -subj '/ST=France/L=Paris/O=42/CN=webservice'

# Genere pour chacun des types de clés (rsa, dsa, ecdsa et ed25519) pour lesquels il n'existe pas de hostkeys
RUN ssh-keygen -A

# Copie les fichiers de configuration dans le container
COPY /srcs/nginx.conf           /etc/nginx/
COPY /srcs/start_service.sh     /

# Copie les fichier pour l'index dans le container
COPY /srcs/images/              /var/www/images
#COPY /srcs/Home.css             /var/www/
#COPY /srcs/Home.html            /var/www/
COPY /srcs/index.html           /var/www/
COPY /srcs/jquery.js            /var/www/
COPY /srcs/nicepage.css         /var/www/
COPY /srcs/nicepage.js          /var/www/
#COPY /srcs/Post-Template.css    /var/www/

#Expose les ports 443, 80 et 22 du containeur
EXPOSE 443 80 22

ENTRYPOINT ["sh", "start_service.sh"]
