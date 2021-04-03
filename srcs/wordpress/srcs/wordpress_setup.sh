#!/bin/sh

#Copy configuration in Nginx's directory.
cp nginx.conf /etc/nginx/

#Boot php-fpm.
/usr/sbin/php-fpm7

#Create nginx directory needed to boot nginx.
mkdir /run/nginx/

#Move wp-config.php in wordpress directory.
mv wp-config.php /var/www/wordpress

#Start Nginx in background.
nginx &

#Check if nginx AND php-fpm7 are still running, if not, end the script to
#restart the container.
ARE_RUNNING=0
while [ $ARE_RUNNING -eq 0 ]
do
    sleep 5
    ps aux | grep -v "grep" | grep "php-fpm7"
    if [ $? -ne 0 ]
    then
        ARE_RUNNING=1
    fi
    ps aux | grep -v "grep" | grep "nginx"
    if [ $? -ne 0 ]
    then
        ARE_RUNNING=1
    fi
done