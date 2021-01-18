# Administración de Wordpress con la utilidad WP-CLI

Con la utilidad WP-CLI podemos realizar las mismas tareas que se pueden hacer desde el panel de administración web de Wordpress, pero desde la línea de comandos.

Los requisitos para esta práctica es tener previamente instalado la pila LAMP en nuestra máquina server, y después de ello comenzamos con la instalación de WP-CLI.

## Instalación de WP-CLI en el servidor LAMP
Descargaremos el archivo wp-cli.phar (.phar spm archivos similares a los archivos .jat), con el comando:

```
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
```

Le asignamos permisos de ejecución con:
```
chmod +x wp-cli.phar
```
Moveremos el archivo al directorio cambiandole el nombre para que sea más sencillo su busqueda:

```
sudo mv wp-cli.phar /usr/local/bin/wp
```

## Instalación de Wordpress con WP_CLI

Nos movemos al directorio /var/www/html

```
cd /var/www/html
```
En ella descargarémos el código fuente de Wordpress con el comando: 

```
wp core download --locale=es_ES --allow-root
```
- Para este comando le añadimos **--allow-root** para habilitar que se acceda mediante root, ya que sin el no nos dejaría ejecutar el comando. 

Una vez hecho esto procederemos a crear una base de datos

```mysql -u root <<< "DROP DATABASE IF EXISTS $DB_NAME;"
mysql -u root <<< "CREATE DATABASE $DB_NAME;"
mysql -u root <<< "CREATE USER $DB_USER@'localhost' IDENTIFIED BY '$DB_PASSWORD';"
mysql -u root <<< "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@'localhost';"
mysql -u root <<< "FLUSH PRIVILEGES;"
```
Una vez creada la base de datos podremos crear el archivo de configuración para Wordpress (wp-config.php):

```
wp config create --dbname=wordpress_db --dbuser=wordpress_user --dbpass=wordpress_password
```
- Al crear el archivo de configuración se crearán automáticamente los valores aleatorios para las secutiry keys

Para comprobar usamos el comando: 

```
wp config get
```

Y por último instalamos Worpress
```
wp core install --url=localhost --title="IAW" --admin_user=admin --admin_password=admin_password --admin_email=test@test.com
