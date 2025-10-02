# Registro de Presencia (RdP)

## Frontend

Desarrollado en Vue.js y Tailwind CSS. Consume la API del backend y proporciona una interfaz de usuario responsiva 

- Vue.js amb Tailwind CSS
- Diseño responsivo para poder ser utilizados en un gran variedad de dispositivos
- Vue-Router para gestionar las rutas
- Pinia para la gestión de estados globales (autenticación, usuarios)
- Autenticación y permisos asignados por roles con Vue Router y Pinia
- Gestión de peticiones HTTP al API del backend con Axios
- Traducciones y multilenguaje con vue-i18n para dar soporte a Valencià, Castellano y English

---

### Características

- **Framework:** Vue 3 + Composition API
- **Lenguaje:** TypeScript
- **Gestión de estado:** Pinia
- **Ruteo:** Vue Router
- **HTTP Client:** Axios
- **Internacionalización:** vue-i18n
- **Testing:** Vitest
- **UI:** Tailwind CSS

---

### Estrutura

```
rdp/
├── frontend/                # Aplicación Vue 3 + Composition API
    ├── public/              # Elementos estáticos
    └── src/
        ├── assets/          # Elementos como imágenes, fuentes, etc.
        ├── components/      # Componentes Vue
        ├── router/          # Configuración del Router Vue
        ├── store/           # Pinia Store
        └── views/           # Vistas Vue

```
