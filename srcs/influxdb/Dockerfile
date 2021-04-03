FROM alpine:latest

# Indique le createur du conteneur
LABEL maintainer="mravily@student.42.fr"
LABEL version="v0.2"
LABEL description="Container run on Alpine Linux for influxdb used like service"

# Update les packages present de bases sous Alpine
RUN apk update

# Telecharge un package pre-install de InfluxDB 
RUN apk add --no-cache influxdb

# Expose le port 8086 du container
EXPOSE 8086

# Lance et exécute tous les processus nécessaires au fonctionnement d'InfluxDB.
CMD	["influxd", "run"]