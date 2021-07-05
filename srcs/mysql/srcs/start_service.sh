#! /bin/sh

# Install la DB MariaDB.
mariadb-install-db -u root

# Lance le Deamon MySQL pour start le server MySQL puis sleep le process.
mysqld -u root & sleep 5

# Creation de la DB Wordpress.
mysql -u root --execute="CREATE DATABASE wordpress;"

# Configure la DB Wordpress.
mysql -u root wordpress < wordpress.sql

# Creation d'un nouvelle utilisateur pour la gestion de la DB Wordpress.
mysql -u root --execute="CREATE USER 'root'@'%' IDENTIFIED BY 'toor'; GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
mysql -u root --execute="USE wordpress;"
mysql -u root --execute="FLUSH PRIVILEGES;"

# Kill le process MySQL Deamon
pkill mysqld

# Lance le Deamon MySQL
mysqld
