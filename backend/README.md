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

