# Pokémon Explorer App - Prueba Técnica Flutter

Este proyecto es una aplicación móvil desarrollada en Flutter para explorar el mundo de Pokémon utilizando la [PokéAPI](https://pokeapi.co/). La aplicación permite listar Pokémon, ver sus detalles, realizar búsquedas y cuenta con un sistema de autenticación básico.

## 🚀 Características

- **Pantalla de Splash**: Animación de carga inicial.
- **Autenticación**: Login con credenciales hardcodeadas (`flutter` / `flutter`).
- **Listado de Pokémon**: Visualización en grid con scroll infinito (paginación).
- **Búsqueda**: Filtro funcional por nombre de Pokémon.
- **Detalle del Pokémon**: Información detallada que incluye estadísticas, tipos, peso, altura y habilidades.
- **Manejo de Estados**: Gestión de estados de carga, error y lista vacía.
- **Diseño Responsive**: Adaptado para diferentes tamaños de pantalla.

## 🛠️ Tecnologías y Librerías

- **Flutter SDK**: Framework principal.
- **Estado (State Management)**: [flutter_meedu](https://pub.dev/packages/flutter_meedu) - Elegido por su ligereza y eficiencia en la gestión de estados reactivos.
- **Navegación**: [go_router](https://pub.dev/packages/go_router) - Para una gestión de rutas declarativa y robusta.
- **HTTP Client**: [Dio](https://pub.dev/packages/dio) - Para el consumo de la PokéAPI.
- **Serialización**: [freezed](https://pub.dev/packages/freezed) y [json_serializable](https://pub.dev/packages/json_serializable) para modelos inmutables y seguros.
- **UI Components**:
  - `shimmer`: Para efectos de carga (skeletons).
  - `lottie`: Para animaciones interactivas.
  - `extended_image`: Para un manejo optimizado de imágenes de red.

## 🏗️ Arquitectura

El proyecto sigue los principios de **Clean Architecture**, permitiendo una separación clara de responsabilidades y facilitando la escalabilidad y mantenibilidad. La estructura original proporcionada fue extendida para soportar esta arquitectura:

### Capas del Proyecto:

1.  **Domain (Dominio)**: Contiene la lógica de negocio pura.
    - `models/`: Definición de los entes de datos (Pokemon, Failures).
    - `repositories/`: Interfaces (contratos) de los repositorios.
    - `responses/`: Modelos de respuesta de la API.
2.  **Data (Datos)**: Implementación de la lógica de datos.
    - `providers/`: Fuentes de datos externas (API, Local).
    - `repositories_impl/`: Implementaciones concretas de las interfaces del dominio.
    - `injects/`: Configuración de la inyección de dependencias.
3.  **Presentation (Presentación)**: Capa de interfaz de usuario.
    - `view/`: Widgets y páginas de Flutter.
    - `controller/`: Notificadores de estado (StateNotifiers de Meedu) que gestionan la lógica de la UI.
    - `widgets/`: Componentes reutilizables específicos de cada módulo.
4.  **Core / Helpers**: Funcionalidades transversales, utilidades de responsive, temas y constantes globales.

## 📋 Requisitos Previos

- Flutter SDK (^3.12.0)
- Dart SDK (^3.12.0)

## ⚙️ Instalación y Ejecución

1.  **Clonar el repositorio:**
    ```bash
    git clone git@github.com:bakamedi/Pokemon_Explorer_App.git
    cd poke_test
    ```

2.  **Instalar dependencias:**
    ```bash
    flutter pub get
    ```

3.  **Generar archivos de código (Modelos/Freezed):**
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

4.  **Ejecutar la aplicación:**
    ```bash
    flutter run
    ```

## 📝 Notas del Desarrollador

- **Arquitectura Extendida**: Se ha refinado la estructura base proporcionada para implementar un flujo de datos más robusto mediante repositorios e inyección de dependencias.
- **Gestión de Estados**: Se implementó un sistema centralizado de manejo de vistas (`appViewStateUtil`) para controlar estados de `loading`, `error`, `empty` y `success` de manera consistente.
- **Pendientes (Extras)**: Por el momento, no se han implementado los puntos extra (Caché local con SharedPreferences, Tests unitarios o Dark mode), priorizando la estabilidad y la arquitectura de las funcionalidades obligatorias.

---
Desarrollado como parte de una prueba técnica para el rol de Desarrollador Flutter.
