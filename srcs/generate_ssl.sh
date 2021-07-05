#!/bin/bash

# Certificat SSL pour ftps
openssl req -x509 -nodes -days 365 \
			-newkey rsa:2048 -subj '/ST=France/L=Paris/O=42/CN=FTPS' \
			-keyout ./srcs/ftps/srcs/vsftpd.key \
			-out ./srcs/ftps/srcs/vsftpd.crt
