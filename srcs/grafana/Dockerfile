
FROM alpine:latest

# Indique le createur du conteneur
LABEL maintainer="mravily@student.42.fr"
LABEL version="v0.2"
LABEL description="Container run on Alpine Linux for server_grafana used like service pod Kubernetes"

# Installe des packages pre-installer de Grafana
RUN		apk add grafana --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache

# Copie les differents fichiers de configuration de Grafana
COPY 	/srcs/defaults.ini 			/usr/share/grafana/conf/defaults.ini
COPY 	/srcs/influxdb.yaml 		/usr/share//grafana/conf/provisioning/datasources/influxdb.yaml
COPY 	/srcs/dashboards.yaml 		/usr/share/grafana/conf/provisioning/dashboards/dashboards.yaml
COPY 	/srcs/dashboards/ 			/usr/share/grafana/dashboards

# Expose le port 3000 du container
EXPOSE	3000

# Permet de changer le répertoire courant de votre image
WORKDIR /usr/share/grafana/conf

# Lance le serveur grafana
CMD	["grafana-server"]