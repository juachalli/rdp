# Registro de Presencia (RdP)

Partimos de la base en la que trabajamos en una máquina virtual completamente nueva, con una instalación de **`Ubuntu 24.04.3 LTS`**

---
## APACHE 2.4.58

En primer lugar instalamos el servidor de **`Apache2`**

```bash
sudo apt update
sudo apt install apache2
```

Comprobamos que está bien instalado
```bash
apache2 -v
# En nuestro caso indica => Apache/2.4.58
```

También podemos comprobar su funcionamiento entrando en:
`http://localhost/`

---

## PHP 8.3.6

A continuación instalamos **`PHP`**

```bash
sudo apt update
sudo apt install php libapache2-mod-php php-mysql php-mbstring php-curl php-fileinfo php-xdebug
```

- Los módulos que instalamos son:
    - libapache2-mod-php => integración PHP con Apache
    - php-mysql => provee mysqli y PDO MySQ
    - php-mbstring => manejo de cadenas multibyte (UTF-8)
    - php-curl => llamadas HTTP salientes por si necesitamos consumir otros servicios
	- php-fileinfo => para updates y para validar MIME types
	- php-xdebug => solo en desarrollo para depuración

Comprobamos que está bien instalado
```bash
php -v
# En nuestro caso indica => PHP 8.3.6
```

Con la información de la versión localizamos y realizamos los siguientes ajustes en el fichero php.ini:

```bash
sudo nano /etc/php/8.3/apache2/php.ini
```
Cambiamos

- error_reporting = E_ALL --501        
- display_errors = On --518
- upload_max_filesize = 50M --865        
- date.timezone = "Europe/Madrid" --989
- Al final del fichero añadimos:
    ```
    [xdebug]
    xdebug.mode=develop,debug
    xdebug.discover_client_host=1
    xdebug.client_port = 9003
    xdebug.start_with_request=yes
    ```
Reinicimos el servidor para que tenga en cuenta los cambios:

```bash
sudo systemctl restart apache2.service
```

---

## MySQL 8.0.43

Vamos a instalar la Base de Datos que en este caso será **`MySQL`**

```bash
sudo apt update
sudo apt install mysql-server
```

Una vez instalado, entramos en la consola y creamos el usuario “admin” con la contraseña que indiquemos en “identified by” (en este caso "admin" también) y le asignamos todos los permisos.

```bash	
sudo mysql
# Al entrar nos muestra la versión que en nuestro caso indica => 8.0.43
    create user 'admin'@'localhost' identified by 'admin';
    grant all privileges on *.* to 'admin'@'localhost' with grant option;
    exit
```

---

## phpMyAdmin 5.2.1

Para facilitar la administración del MySQL vamos a instalar la herramienta **`phpMyAdmin`** 

```bash
sudo apt update
sudo apt install phpmyadmin
```

- NOTA:
    ```
    Durante la instalación nos aparecerá un cuadro de diálogo, donde debemos marcar un “*” en el servidor web que estamos utilizando, que en este caso es Apache2. Para seleccionar la opción, lo hacemos con la barra espaciadora
    ```

Una vez finalizada la instalación podemos comprobar su funcionamiento en:
`http://localhost/phpmyadmin/`

Podemo saber la versión de nuestro phpMyAdmin, entrando en el portal o con el comando siguiente que nos muestra la versión entre otra mucha información

```bash
apt show phpmyadmin
# En nuestro caso indica => 5.2.1
```

---

## Composer 2.8.12

Para la parte del backend instalamos **`Composer`** con el objetivo de poder gestionar posteriormente todas las dependencias de PHP

Seguimos las instrucciones que nos indican en
- https://getcomposer.org/download/

```bash
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'ed0feb545ba87161262f2d45a633e34f591ebb3381f2e0063c345ebea4d228dd0043083717770234ec00c5a9f9593792') { echo 'Installer verified'.PHP_EOL; } else { echo 'Installer corrupt'.PHP_EOL; unlink('composer-setup.php'); exit(1); }"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer
# En nuestro caso indica => Composer (version 2.8.12) successfully installed 
```

---

## Node.js v24.9.0 y npm 11.6.0

Para la parte del frontend instalamos **`node`** y **`npm`** con el objetivo de poder gestionar las dependencias que utilicemos.

Para obtener el código vamos a la página oficial de Node.js
- https://nodejs.org/es

y nos descargamos el código a utilizar para la realizar la instalación en base a nuestra selección
```bash
# Descarga e instala nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
# en lugar de reiniciar la shell
\. "$HOME/.nvm/nvm.sh"
# Descarga e instala Node.js:
nvm install 24
# Verify the Node.js version:
node -v # Should print "v24.9.0".
# Verifica versión de npm:
npm -v # Debería mostrar "11.6.0".
```

---

## Git 2.43.0

Para el control del código y su versionado utilizaremos **`Git`**

```bash
sudo apt update
sudo apt install git
```

Comprobamos que se ha instalado correctamente verificando
```bash
git --version
# En nuestro caso indica git version 2.43.0
```

### Creamos la estructura de carpetas e inicializamos git

1. **Creamos la carpeta principal del proyecto y las subcarpetas y accedemos a ella:**
```bash
mkdir rdp
cd rdp
mkdir backend frontend corporate
```

2. **Inicializamos git en nuestro local:**
```bash
# Establecemos las configuraciones globales de nuestro repositorio
git config --global init.defaultBranch main
git config --global user.name "juachalli"
git config --global user.email "juachalli@alu.edu.gva.es"
git config --list
# Inicializamos el repositorio
git init
```
   
3. **Creamos repositorio en GitHub y vinculamos nuestro repositorio local con el remoto que acabamos de crear:**
```bash
# Añadimos el repositorio remoto de GitHub (que le hemos llamado rdp)
git remote add origin https://github.com/juachalli/rdp.git

# Verificamos que se añadió correctamente
git remote -v
```

4. **Subimos los cambios a la rama main que es en la que estamos:**
```bash
git add .
git commit -m "Primer commit con la estructura inicial"	
git push -u origin main
```
 
---









