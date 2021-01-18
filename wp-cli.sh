#!/bin/bash
set -x

#VARIABLES
BD_ROOT_PASSWD=root
DB_NAME=wordpress_db
DB_USER=wordpress_user
DB_PASSWORD=wordpress_password

# Actualizamos la lista de paquetes
apt update

#Actualizamos los paquete
apt upgrade -y

# Instalamos el servidor web Apache
apt install apache2 -y

# Instalamos el MySQL Server
apt install mysql-server -y

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

#Descargamos el código fuente de Wordpress
wp core download --locale=es_ES --allow-root

#Creamos la base de datos
mysql -u root <<< "DROP DATABASE IF EXISTS $DB_NAME;"
mysql -u root <<< "CREATE DATABASE $DB_NAME;"
mysql -u root <<< "CREATE USER $DB_USER@'localhost' IDENTIFIED BY '$DB_PASSWORD';"
mysql -u root <<< "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@'localhost';"
mysql -u root <<< "FLUSH PRIVILEGES;"

#Creamos el archivo de configuración
wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=DB_PASSWORD --allow-root

#Instalamos Wordpress
wp core install --url=http://54.152.35.182 --title="IAW" --admin_user=admin --admin_password=admin --admin_email=admin@admin.com --allow-root
