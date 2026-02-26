# MonteBit

MonteBit es una aplicación móvil desarrollada en Flutter diseñada con un enfoque riguroso en la mantenibilidad, escalabilidad y la experiencia de usuario.

## � Demostración

[![App Demo](https://img.youtube.com/vi/HrV6P0HIj8g/maxresdefault.jpg)](https://www.youtube.com/watch?v=HrV6P0HIj8g)
*(Haz clic en la imagen superior para ver el video explicativo)*

## �🚀 Requisitos Previos

Asegúrate de tener instalado tu entorno de desarrollo preparado para Flutter:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Versión recomendada: >=3.0.0)
- Dart SDK
- Android Studio / Xcode (para emuladores y construcción de los binarios)

## 🛠️ Cómo Ejecutar el Proyecto

1. Clona el repositorio y navega a la raíz del proyecto.
2. Descarga las dependencias del proyecto ejecutando:
   ```bash
   flutter pub get
   ```
3. Conecta un emulador o un dispositivo físico.
4. Lanza la aplicación desde la terminal o desde tu IDE:
   ```bash
   flutter run
   ```

## 🧪 Pruebas Unitarias y Cobertura (Testing)

Este proyecto tiene un altísimo estándar de calidad, contando con aproximadamente un **100% de cobertura de pruebas unitarias** en sus componentes de lógica de negocio o *Core*, como BLoCs, Repositories, Datasources, Entities y Eventos.

Para ejecutar todas las pruebas unitarias:
```bash
flutter test
```

Para generar y visualizar el reporte detallado de `coverage` HTML en tu navegador, primero asegúrate de tener instalada la herramienta `lcov` en tu sistema:

- **En macOS** (usando Homebrew):
  ```bash
  brew install lcov
  ```
- **En Linux** (Ubuntu/Debian):
  ```bash
  sudo apt-get install lcov
  ```
- **En Windows** (usando Chocolatey):
  ```bash
  choco install lcov
  ```

Una vez instalada la herramienta, ejecuta los siguientes comandos en la raíz del proyecto para generar y abrir el reporte:
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html   # En macOS. En Linux usa 'xdg-open', en Windows usa 'start'.

O bien puedes ir a la ruta coverage/html/index.html y abrir el archivo en tu navegador.
```

## 🏗️ Arquitectura y Estructura de Carpetas

La aplicación está construida utilizando los principios de **Clean Architecture** (Arquitectura Limpia) combinada con una estructura orientada a **Features (Funcionalidades)**. Esto significa que cada flujo de la aplicación es independiente, lo que facilita encontrar y escalar el código del proyecto sin conflictos a largo plazo.

El proyecto se divide principalmente de la siguiente manera:

```text
lib/
├── core/               # Código compartido: Tema, Entidades base, Enums, Errores y UI genérica
│   ├── domain/         # Entidades genéricas (ej. CardEntity, Response) y Enums
│   └── ui/             # Componentes visuales genéricos y reusables, theme.dart
├── di/                 # Punto de entrada de la Inyección de Dependencias
├── features/           # Módulos específicos y aislados de la app
│   ├── add_card/
│   ├── cards/
│   ├── login/
│   ├── profile/
│   └── signup/
```

Dentro de cada `feature`, se mantiene una separación estricta de responsabilidades:
- **`data/`**: (Datasources y Repositories) Implementación de consumo de APIs (ej. Dio) y almacenamiento local.
- **`domain/`**: (Entities, Failures, Exceptions) Lógica pura de negocio de esa funcionalidad, totalmente independiente de librerías externas.
- **`ui/`**: 
  - **`bloc/`**: Manejo de estado utilizando el patrón BLoC mediante Eventos y Estados.
  - **`widgets/`**: Interfaz de usuario inteligentemente dividida en **widgets pequeños, precisos y entendibles**, aplicando el principio de responsabilidad única.
  - **`pages/`**: Pantallas principales que agrupan a esos mismos widgets pequeños para formar un layout.

## 💉 Inyección de Dependencias

Para el manejo de dependencias de la aplicación (como clientes HTTP, repositorios, y BLoCs) se emplea un sistema de **Inyección de Dependencias (DI)** centralizado bajo la carpeta `lib/di/`.

Esto nos permite una grandísima ventaja técnica:
- **Desacoplamiento**: Separar la construcción y memoria de objetos complejos de la interfaz de usuario.
- **Testabilidad**: Intercambiar implementaciones con extrema facilidad (por ejemplo, inyectar *Mock Repositories* falsos a los BLoC durante las pruebas unitarias).
- Garantizar de forma fluida el estilo de vida de los servicios (creación de singletons vs fábricas reactivas).

## 🎨 Manejo del Diseño (Theme)

Para mantener una coherencia visual, optimizar tiempo de desarrollo y asegurar que cualquier cambio estético suceda rápido en toda la aplicación, usamos el sistema de diseño centralizado de **Theme** provisto por Flutter.

Todo el esfuerzo visual recae en el archivo `lib/core/ui/theme.dart`.

* **Ventajas de esta aproximación**:
  * Todos los componentes visuales genéricos leen contextualmente su color o formato base a través de `Theme.of(context)`.
  * La interfaz de los widgets de negocio queda extraordinariamente magra; el core de `theme.dart` dicta con autoridad cómo se ven los botones genéricos, sombras de los text fields, animaciones de alerta y navegación en toda la app a la vez.

## 🛑 Manejo de Errores

El proyecto implementa un ecosistema reactivo, seguro y escalable para la constante captura de errores:
1. **Recepción Exterior (`Exceptions`)**: En la capa más lejana, los `Datasources` validan respuestas de red y levantan Excepciones genéricas explícitas de arquitectura (ej. `UnauthorizedException`).
2. **Transformación a Regla de Negocio (`Failures`)**: Dentro de los `Repositories` de Clean Architecture, atrapamos estas Exceptions usando bloques `try/catch` y las transformamos a objetos elegantes y orientados a la app llamados **Failures** (ej. `EmailOrPhoneAlreadyInUseFailure`).
3. **Transporte Seguro (`Response`)**: Empleamos la clase tipo "Response" que viaja a la capa de UI devolviendo: o bien los datos exitosos (`Response.success`), o el contexto controlado de un error (`Response.failed(Failure)`).
4. **BLoC a UI**: BLoC abre o lee este envoltorio de manera segura y emite el Fallo al `State`. La vista únicamente interpreta cuál era el error de negocio y despliega el visualizador correspondiente al usuario para permitir un flujo sin interrupciones ni cierres repentinos en el framework.
