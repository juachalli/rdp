# Registro de Presencia (RdP)

## Descripción del Proyecto
Aplicación Web para la gestión y control de la presencia laboral en una empresa.

La plataforma permite a los empleados registrar la hora de entrada y salida, solicitar y gestionar sus vacaciones, justificar ausencias, adjuntar justificantes, generar informes de sus jornadas laborales y recibir notificaciones generales de la empresa.

La aplicación puede ser utilizada por varias empresas simultaneamente gracias al control que se realiza por empresa (por ejemplo una asesoría que ofreciera el servicio a sus clientes)

## Características
- **Multiempresa**: La aplicación permite que varias empresas utilicen la plataforma simultáneamente.
- **Gestión de Asistencia/Ausencias/Vacaciones**: Registro de horas de entrada y salida, así como la gestión de solicitudes de vacaciones y ausencias
- **Informes**: Generación de informes sobre las jornadas laborales, vacaciones y ausencias de los empleados
- **Notificaciones**: Sistema de notificaciones para mantener a los empleados informados sobre noticias y actualizaciones de la empresa
- **Multiidioma**: Entorno personalizado con traducciones a Valenciano/Castellano/Inglés

## Entorno de Desarrollo
- **SO**: Máquina Virtual Linux (Ubuntu 24)
- **Servidor Web**: Apache/2.4.58
- **Base de Datos**: MySQL 8.0.43
- **PHP**: PHP 8.3.6
- **Composer**: Composer 2.8.12
- **Symfony CLI**: Version 5.12.0
- **Node**: Node v24.9.0
- **NPM**: npm 11.6.0
- **Control de Versiones**: Git version 2.43.0
- **IDE**: Visual Studio Code

## Entorno de Producción
- **Hosting**: Hostinger (hosting compartido)
- **Servidor Web**: Apache
- **PHP**: PHP 8.3
- **Base de Datos**: MySQL

## Aquitectura del Proyecto

El proyecto sigue el modelo de una arquitectura Cliente/Servidor y está dividido en tres partes principales: **Backend**, **Frontend** y **Corporate**

#### **Ventajas de este modelo**
- **Desacoplamiento total:** El frontend y el backend pueden evolucionar de forma independiente.
- **Escalabilidad:** Puedes escalar el backend y el frontend por separado.
- **Mantenibilidad:** Separación clara de responsabilidades.


## Estructura del Proyecto
A grandes rasgos la estructura del proyecto será similar a la siguiente

```
rdp/
├── backend/                 # Aplicación PHP + Symfony
│   ├── config/              # Carpeta de configuración de Symfony
│   │   ├── packages/        # Configuración de paquetes (doctrine, cors, etc.)
│   │   ├── routes/          # Configuración de rutas
│   │   └── jwt/             # Claves pública y privada de JWT
│   ├── migrations/          # Migraciones de la Base de Datos
│   ├── src/
│   │   ├── Controller/      # Controladores de la API
│   │   ├── Entity/          # Entidades del modelo
│   │   ├── Repository/      # Repositorio de Consultas personalizadas
│   │   ├── Service/         # Lógica de negocio (servicios)
│   │   ├── Security/        # Clases relacionadas con la seguridad (votantes, autenticación)
│   │   ├── EventListener/   # Listeners para eventos del sistema
│   │   ├── Serializer/      # Normalizadores y desnormalizadores personalizados
│   │   └── Validator/       # Validadores personalizados
│   └── tests/               # Tests del backend
│   │   ├── Test1/           # Tests del backend - 1
│   │   └── Test2/           # Tests del backend - 2
│
├── frontend/                # Aplicación Vue 3 + Composition API
│   ├── public/              # Elementos estáticos
│   └── src/
│       ├── assets/          # Elementos como imágenes, fuentes, etc.
│       ├── components/      # Components Vue
│       ├── router/          # Configuración del Router Vue
│       ├── store/           # Pinia Store
│       └── views/           # Vistes Vue
│
└── corporate/               # Pàgina corporativa
```

## Instalación en DESARROLLO

0. Configurar el entorno de desarrollo, instalando las herramientas indicadas en el documento ENTORNO.md

1. Clona el repositorio.

2. Configura el entorno en el backend, incluyendo las variables de entorno en el archivo `.env`.

3. Instala las dependencias del backend usando Composer.
     ```
     composer install
     ```

4. Inicia el servidor de desarrollo
     ```
     php -S localhost:8000 -t public
     ```

5. Instala las dependencias del frontend usando npm.
     ```
     npm install
     ```

6. Inicia el servidor backend de desarrollo
     ```
     npm run serve
     ```	 

## Instalación en PRODUCCION

 - Despliegue en un Hosting compartido en Hostinger
 - Backend con PHP 8.3 y Symfony
 - Base de datos MySQL.
 - Frontend compilado i subido a la carpeta public/.
 - Configurar .htaccess para que todas las rutas vayan a index.php.


## URLs del Sistema

- `http://www.registrodepresencia.com`


## Contribuciones
Las contribuciones son bienvenidas. Si deseas contribuir, por favor abre un issue o envía un pull request.


## Licencia
Este proyecto está bajo la Licencia MIT.

