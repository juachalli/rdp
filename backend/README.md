# Registro de Presencia (RdP)

## Backend

Desarrollado en PHP utilizando Symfony. Proporciona una API que se conecta a bases de datos MySQL, para enviar y/o recibir información desde el Frontend

- PHP con framework Symfony
- Base de datos MySQL
- Arquitectura RESTful
- Doctrine/ORM para la gestión de base de datos
- Control de accesos con Symfony Security para restringir funcionalidades según el Rol del usuario
- Autenticación por Tokens con JWT (LexikJWTBundle)
- Exportación de datos en formato CSV o Excel (SpoutBundle)
- Configuración de CORS en Symfony para permitir llamadas desde el frontend

---

### Características

- **Base de datos:** MySQL 8.0.43
- **Lenguaje:** PHP 8.3.6
- **Framework:** Symfony 7.3.1
- **API:** RESTful (JSON)
- **ORM:** Doctrine
- **Autenticación:** JWT (LexikJWTAuthenticationBundle)
- **Gestión de migraciones:** Doctrine Migrations
- **CORS:** Configurado en Symfony para permitir peticiones desde el frontend
- **Testing:** PHPUnit

- Documentación de la API con **OpenAPI/Swagger** (también se podría haber usado NelmioApiDocBundle en Symfony).

---

### Estrutura

```
rdp/
└── backend/                 # Aplicación PHP + Symfony
    ├── config/              # Carpeta de configuración de Symfony
    │   ├── packages/        # Configuración de paquetes (doctrine, cors, etc.)
    │   ├── routes/          # Configuración de rutas
    │   └── jwt/             # Claves pública y privada de JWT
    ├── migrations/          # Migraciones de la Base de Datos
    ├── src/
    │   ├── Controller/      # Controladores de la API
    │   ├── Entity/          # Entidades del modelo
    │   ├── Repository/      # Repositorio de Consultas personalizadas
    │   ├── Service/         # Lógica de negocio (servicios)
    │   ├── Security/        # Clases relacionadas con la seguridad (votantes, autenticación)
    │   ├── EventListener/   # Listeners para eventos del sistema
    │   ├── Serializer/      # Normalizadores y desnormalizadores personalizados
    │   └── Validator/       # Validadores personalizados
    └── tests/               # Tests del backend
        ├── Test1/           # Tests del backend - 1
        └── Test2/           # Tests del backend - 2
```


## Instalaciones para el Backend

### 1. Creamos el proyecto backend:
```bash
cd backend
symfony new .
# Cuando termine nos indicará algo similar a:
# [OK] Your project is now ready in /var/www/html/rdp/backend
```
	
### 2. Instalamos los paquetes que vamos a necesitar:
   
#### 2.1 => Componentes de base de datos

Instalamos el paquete `symfony/orm-pack` que es un "pack" que incluye varios paquetes relacionados con Doctrine ORM y que son útiles para trabajar con bases de datos en Symfony.

```bash
composer require symfony/orm-pack
```

Paquetes incluidos en symfony/orm-pack (y algunas dependencias adicionales)

- doctrine/orm

	El núcleo de Doctrine ORM, que permite mapear entidades a tablas de base de datos y realizar consultas.

- doctrine/doctrine-bundle

	Integra Doctrine ORM con Symfony. Proporciona configuraciones predeterminadas, comandos de consola (doctrine:schema:update, doctrine:migrations:migrate, etc.) y servicios para trabajar con Doctrine en Symfony.

- doctrine/doctrine-migrations-bundle

	Permite gestionar migraciones de base de datos en Symfony. Es útil para versionar cambios en el esquema de la base de datos.

- doctrine/dbal

	La capa de abstracción de base de dades

- **Creamos la base de datos**

	Para crear la base de datos podemos utilizar la herramienta

	```bash
	php bin/console doctrine:database:create
	```

	Aunque yo prefiero crearla manualmente
	```bash
	sudo mysql
		CREATE USER 'db_user'@'%' IDENTIFIED BY 'db_password';
		CREATE DATABASE db_name;
		GRANT ALL PRIVILEGES ON db_name.* TO 'db_user'@'%';
		EXIT
	```

- **Configuramos la conexión a la base de datos**

	Hacemos una copia del archivo `.env` a un archivo llamado `env.local`. Editamos ese archivo para configurar la conexión a nuestra base de datos MySQL.

	```
	DATABASE_URL="mysql://db_user:db_password@127.0.0.1:3306/db_name?serverVersion=8.0.43&charset=utf8mb4"
	```

- **Validamos que hay conexión**

	```bash
	symfony console doctrine:schema:validate; 
	```

#### 2.2 => Instalar seguridad y autenticación

Importantes para la gestión de roles, la autenticación de usuarios y la autenticación JWT basada en tokens.

```bash
# Instalar el bundle de seguridad para gestión de roles y autenticación de usuarios:
composer require symfony/security-bundle
# Instalar JWT para autenticación en la API por tokens
composer require lexik/jwt-authentication-bundle	
```	

- **Configuramos JWT**

Generamos las claves JWT:

```bash
mkdir ./config/jwt
php bin/console lexik:jwt:generate-keypair
```

Nos va a crear dos ficheros:
- `config/jwt/private.pem` (clave privada)
- `config/jwt/public.pem` (clave pública)

**IMPORTANTE**: Nos aseguramos de que estos ficheros no se compartan publicamente añadiéndolos al `.gitignore` si no están.

```bash
###> lexik/jwt-authentication-bundle ###
/config/jwt/*.pem
###< lexik/jwt-authentication-bundle ###
```

Actualizamos la configuración JWT teniendo en cuenta que la información la tenemos definida de el fichero `.env`

- `config/packages/lexik_jwt_authentication.yaml`

```bash
lexik_jwt_authentication:
    secret_key: '%env(resolve:JWT_SECRET_KEY)%' # Ruta a la clave privada
    public_key: '%env(resolve:JWT_PUBLIC_KEY)%' # Ruta a la clave pública
    pass_phrase: '%env(JWT_PASSPHRASE)%' # Frase de paso para la clave privada
    token_ttl: '%env(int:JWT_TOKEN_TTL)%'  # Tiempo de vida del token en segundos
    user_id_claim: sub # Campo del token que contiene la identidad
    encoder:
        signature_algorithm: RS256 # Algoritmo de firma explícito
```

#### 2.3 => API

Fundamental para permitir comunicación entre el Frontend Vue y el Backend Symfony de manera segura.

	```bash
	# Instalamos CORS para permitir peticiones desde el frontend (Vue)
	composer require nelmio/cors-bundle
	```

Actualizamos la configuración de CORS, teniendo en cuenta que la información la tenemos definida de el fichero `.env`

- `config/packages/nelmio_cors.yaml`

```bash
nelmio_cors:
    defaults:
        origin_regex: '%env(bool:CORS_ORIGIN_REGEX)%'
        allow_origin: ['%env(CORS_ALLOW_ORIGIN)%']
        allow_methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'] # Métodos HTTP más comunes para APIs RESTful
        allow_headers: ['Accept', 'Content-Type', 'Authorization', 'X-Requested-With'] # Permite encabezados necesarios para solicitudes API modernas
        expose_headers: ['Authorization', 'Content-Disposition', 'Link', 'X-Total-Count', 'X-RateLimit-Remaining'] # Encabezados expuestos al cliente
        allow_credentials: true #  Indica que se deben enviar los tokens JWT en el header con credentials: include.
        max_age: 3600 # Tiempo máximo en segundos que el navegador puede almacenar la respuesta CORS.
    paths:
        '^/': null
```


#### 2.4 => Instalar validación y serialización

Importantes para validar datos de entrada y para serializar objetos a JSON.
	```bash
	# Para validar datos de entrada
	composer require symfony/validator
	# Para convertir objetos a JSON
	composer require symfony/serializer	
	```	

#### 2.5 => Herramientas de desarrollo

Esenciales para el desarrollo eficiente y ayuda en la generación de código

	```bash
	# Generador de código
	composer require symfony/maker-bundle --dev
	```

#### 2.6 => Funcionalidades adicionales (No instaladas)

-  **Utilidades**
Proporcionan funcionalidades importantes como soporte multiidioma, gestión de ficheros, logging
	```bash
	# Bundle de traducción para soporte multiidioma
	composer require symfony/translation
	# Bundle para subir y gestionar ficheros (justificantes, adjuntos)
	composer require vich/uploader-bundle
	# Logger para logs
	composer require symfony/monolog-bundle	
	```	
	
-  **Herramientas para los emails**
Cruciales para el envío de correos electrónicos y la verificación de emails en funcionalidades como el registro de usuarios.
	```bash
	# Mailer para envío de correos (notificaciones, etc.)
	composer require symfony/mailer
	# Instalar bundle para verificación de email (útil para registro y seguridad):
	composer require symfonycasts/verify-email-bundle
	```	
	
-  **Herramientas de desarrollo**
Esenciales para el desarrollo eficiente, la generación de código, las pruebas unitarias y el análisis de código.
	```bash
	# Testing
	composer require phpunit/phpunit --dev
	# Opcional: Análisis de código
	composer require psalm/plugin-symfony --dev
	```	

-  **Opcionalmente (de momento no se instalarán)**
	```bash
	# Instalar twig para plantillas si se necesita (aunque el frontend será Vue, puede ser útil para emails o páginas corporativas):
	composer require twig

	# Instalar API Platform o paquetes relacionados para crear la API REST:
	composer require api

	# Formulario (por si necesitas formularios en el backend)
	composer require symfony/form
	```	

- **Sugerencias adicionales**
	```bash
	# Documentación de la API. Esto te permite generar documentación Swagger/OpenAPI automáticamente.
	composer require nelmio/api-doc-bundle
	
	# Rate Limiting (limitación de peticiones) si te preocupa la seguridad y el abuso de la API:
	composer require symfony/rate-limiter

	# Cache si vas a manejar datos que se pueden cachear (por ejemplo, configuraciones, catálogos, etc.):
	composer require symfony/cache
	```	

---



NOTAS

3. En tu UserProvider
Debes crear un método personalizado que busque el usuario por cualquiera de esos campos:

php
public function loadUserByIdentifier(string $identifier): UserInterface
{
    return $this->userRepository->findOneByIdentifier($identifier);
}
Y en el repositorio:

php
public function findOneByIdentifier(string $identifier): ?User
{
    return $this->createQueryBuilder('u')
        ->where('u.email = :id OR u.username = :id OR u.nif = :id OR u.telefono = :id')
        ->setParameter('id', $identifier)
        ->getQuery()
        ->getOneOrNullResult();
}

Y en tu clase UserProvider:

php
class UserProvider implements UserProviderInterface
{
    private UserRepository $userRepository;

    public function __construct(UserRepository $userRepository)
    {
        $this->userRepository = $userRepository;
    }

    public function loadUserByIdentifier(string $identifier): UserInterface
    {
        return $this->userRepository->findOneByIdentifier($identifier);
    }

    public function refreshUser(UserInterface $user): UserInterface
    {
        return $user;
    }

    public function supportsClass(string $class): bool
    {
        return $class === User::class;
    }
}
Y en tu UserRepository:

php
public function findOneByIdentifier(string $identifier): ?User
{
    return $this->createQueryBuilder('u')
        ->where('u.email = :id OR u.username = :id OR u.nif = :id OR u.telefono = :id')
        ->setParameter('id', $identifier)
        ->getQuery()
        ->getOneOrNullResult();
}
