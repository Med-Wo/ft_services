#!/bin/sh

# Si le dossier /var/run/nginx n'existe pas creer le dossier sinon lance php et le deamon nginx
if [[ ! -d /var/run/nginx ]]; then
	mkdir -p /var/run/nginx
fi
# Demarre le SSH deamon et permets au superviseur de controler le service
/usr/sbin/sshd && nginx -g 'daemon off;'
