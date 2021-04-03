#! /bin/sh

if [[ ! -d /run/mysqld/ ]]; then
	mkdir -p /run/mysqld/
fi
# Install la DB MariaDB.
mariadb-install-db -u root

# Lance en arriere-plan le Deamon MySQL pour start le server MySQL.
mysqld &

# Creer un DB pour Worpress
mysql -u root --execute="CREATE DATABASE wordpress;"

# Import previously backed up database to MariaDB database server (wordpress < /wordpress.sql).
#mysql -u root wordpress < wordpress.sql

# Creer un nouvelle utilisateur et lui accorde les priviliges pour manager la DB.
mysql -u root --execute="CREATE USER 'root'@'%' IDENTIFIED BY 'toor';"
mysql -u root --execute="GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
mysql -u root --execute="USE wordpress;"
mysql -u root --execute="FLUSH PRIVILEGES;"

# Kill le process MySQL Deamon
pkill mysqld

# Lance le Deamon MySQL
mysqld

