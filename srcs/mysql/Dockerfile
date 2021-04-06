# Image sous laquel le container est basee
FROM alpine:latest

# Indique le createur et diverses informations concernant le container
LABEL maintainer="mravily@student.42.fr"
LABEL version="v0.4"
LABEL description="Container runs under Alpine Linux with MySQL for management databases used as pod services by K8S"

# Mettre à jour l'index des packages disponibles  
RUN apk update 

# Install les packages pour MySQL
RUN		apk add mariadb mariadb-client

# Creer dossier pour le Deamon MySQL car non present de base sur l'OS
RUN		mkdir -p /run/mysqld/

# Copie les fichiers de configurations dans le container
COPY	/srcs/my.cnf					/etc/
#COPY	/srcs/wordpress.sql				/
COPY	/srcs/start_service.sh			/

# Expose le port du container
EXPOSE 3306

ENTRYPOINT	["sh", "start_service.sh"]