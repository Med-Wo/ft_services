FROM alpine:latest

# Indique le createur du conteneur
LABEL maintainer="mravily@student.42.fr"
LABEL version="v0.8"
LABEL description="Container run on Alpine Linux for Nginx used like service pod Kubernetes"

# Update les composants deja present 
RUN apk update

# Installe les differents package pour nginx
	# Installe le serveur nginx
RUN apk add nginx
	# Install OPENSSL pour le certificat SSL
RUN apk add openssl
	# Install OPENSSH pour le SSH
RUN apk add openssh

#Le répertoire /run/nginx n'existe pas sur les derniers conteneurs alpine, creation du repertoire pour le lancement du daemon nginx via k8s
RUN mkdir -p /run/nginx

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

# Copie les fichiers dans le container
COPY /srcs/nginx.conf /etc/nginx/
COPY /srcs/index.html /var/www/
COPY /srcs/start_service.sh /

#Expose les ports 443, 80 et 22 du containeur
EXPOSE 443 80 22

ENTRYPOINT ["sh", "start_service.sh"]
