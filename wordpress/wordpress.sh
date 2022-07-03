#!/bin/bash

apt-get -y update
      
# Install apache, mariadb and wordpress dependencies
apt-get install -y apache2 mariadb-client mariadb-server curl ghostscript libapache2-mod-php mariadb-client php php-bcmath php-curl php-imagick php-intl php-json php-mbstring php-mysql php-xml php-zip

mysql -uroot -e"CREATE DATABASE wordpress;grant all privileges on wordpress.* to 'wordpress'@'localhost' IDENTIFIED BY '$PASSWORD';flush privileges;"

if ! test -f "/var/www/html/index.php"; then
    curl -sS https://wordpress.org/latest.tar.gz | sudo tar zx -C /var/www/html/ --strip-components=1
    chown -R www-data: /var/www/html
    rm -f /var/www/html/index.html
fi