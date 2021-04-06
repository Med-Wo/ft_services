# Image sous laquel le container est basee
FROM alpine:latest

# Indique le createur et diverses informations concernant le container
LABEL maintainer="mravily@student.42.fr"
LABEL version="v0.4"
LABEL description="Container run on Alpine Linux for MySQL used like service pod Kubernetes"

# Mettre à jour l'index des packages disponibles  
RUN apk update 

# Install les packages pour MySQL
RUN		apk add mariadb mariadb-client

RUN		mkdir -p /run/mysqld/

COPY	/srcs/my.cnf					/etc/
#COPY	/srcs/wordpress.sql				/
COPY	/srcs/start_service.sh			/

EXPOSE 3306

ENTRYPOINT	sh start_service.sh