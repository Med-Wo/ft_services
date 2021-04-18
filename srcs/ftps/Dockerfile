FROM alpine:latest

# Indique le createur du conteneur
LABEL maintainer="mravily@student.42.fr"
LABEL version="v1.0"
LABEL description="Container run on Alpine Linux for server ftps used like service pod Kubernetes"

# Mise a jour des paquets et installation des paquets VSFTPD et OPENSSL
RUN		apk update && apk add vsftpd openssl
# Ajoute un user pour le FTP
RUN 	adduser -D ftpuser
RUN		echo "ftpuser:pwd" | chpasswd

# Lance le deamon very-secure ftp avec notre fichier de configuration
CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]