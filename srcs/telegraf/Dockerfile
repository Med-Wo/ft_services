FROM alpine:latest

# Indique le createur et les information concernant le conteneur
LABEL maintainer="mravily@student.42.fr"
LABEL version="v0.4"
LABEL description="Container run under Alpine Linux with telegraf for metrics collection used as pod service by K8S"

# Update les packages present de bases sous Alpine
RUN apk update

# Installe les paquets pour Telegraf
RUN apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache

# Copie le fichier de configuration dans containers
COPY	/srcs/telegraf.conf			/etc/telegraf/

# Expose le port du container
EXPOSE 8125

CMD	["telegraf", "start", "--config", "/etc/telegraf.conf"]