FROM alpine:latest

# Indique le createur du conteneur
LABEL maintainer="mravily@student.42.fr"
LABEL version="v0.2"
LABEL description="Container run on Alpine Linux for server ftps used like service pod Kubernetes"

# Mise a jour des paquets et installation des paquets VSFTPD et OPENSSL
RUN		apk update && apk add vsftpd openssl
# Change le mot de pass de ROOT
RUN		echo "root:toor" | chpasswd
# Generation d'une cle et certificat SSL
RUN		openssl req -x509 -nodes -days 365 \
			-newkey rsa:2048 -subj '/ST=France/L=Paris/O=42/CN=FTPS' \
			-keyout /etc/ssl/private/vsftpd.key \
			-out /etc/ssl/certs/vsftpd.crt

# Copie le fichier de configuration dans le container
COPY	/srcs/vsftpd.conf	/etc/vsftpd

# Expose les ports du container
EXPOSE	21 40000

# Lance le deamon very-secure ftp avec notre fichier de configuration
CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]
