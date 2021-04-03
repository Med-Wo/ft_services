FROM alpine:latest

# Indique le createur du conteneur
LABEL maintainer="mravily@student.42.fr"
LABEL version="v0.2"
LABEL description="Container run on Alpine Linux for telegraf used like service"

RUN apk update
RUN apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache

COPY	/srcs/telegraf.conf			/etc/telegraf/

EXPOSE 8125

#CMD	["telegraf"]
CMD	["telegraf", "start", "--config", "/etc/telegraf.conf"]