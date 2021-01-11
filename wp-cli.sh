#!/bin/bash
set -x

# Actualizamos la lista de paquetes
apt update

#Actualizamos los paquete
apt upgrade -y

# Instalamos el servidor web Apache
apt install apache2 -y

# Instalamos el MySQL Server
apt install mysql-server -y

# Definimos la contraseña root de MySQL
BD_ROOT_PASSWD=root

# Actualizamos la contraseña de root de MySQL
mysql -u root <<< "ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY '$BD_ROOT_PASSWD';"
mysql -u root <<< "FLUSH PRIVILEGES;"

# Instalamos los módulos de PHP
apt install php libapache2-mod-php php-mysql -y

#Descargamos el archivo wp-cli.phar
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

#Asignamos permisos de ejecución
chmod +x wp-cli.phar

#Movemos el archivo al directorio /usr/local/bin
mv wp-cli.phar /usr/local/bin/wp

------------------ INSTALACIÓN WORDPRESS CON WP-CLI ---------------------

#Nos situamos en el directorio donde vamos a realizar la instalación.
cd /var/www/html
