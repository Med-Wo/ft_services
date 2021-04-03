#!/bin/sh

# Demarre le SSH deamon et permets au superviseur de controler le service
/usr/sbin/sshd && nginx -g 'daemon off;'
