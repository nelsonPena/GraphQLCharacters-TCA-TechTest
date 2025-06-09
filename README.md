# RickAndMortyTCA

## Introducción

Este repositorio contiene **dos implementaciones distintas** de la prueba técnica, organizadas en carpetas separadas:

* Una solución basada en **TCA (The Composable Architecture)**, una arquitectura moderna diseñada para escalar en equipos grandes y facilitar pruebas, modularización y control predecible del estado.
* Una segunda solución utilizando **Arquitectura Limpia** combinada con el patrón **MVVM**, siguiendo principios SOLID, separación por capas e inyección de dependencias tradicional.

Elegí presentar ambas alternativas para mostrar dos enfoques complementarios. He venido profundizando en TCA durante los últimos meses, ya que su uso se ha popularizado en compañías con grandes equipos y necesidades de mantenimiento a largo plazo. Por otro lado, la versión con arquitectura limpia permite mostrar un enfoque más clásico, también alineado con buenas prácticas y testabilidad.

TCA no es solo una arquitectura conceptual, sino una librería oficial mantenida por el equipo de Point-Free, disponible en: [https://www.pointfree.co/collections](https://www.pointfree.co/collections)

---

## Modularización de Aplicaciones iOS con SwiftUI y Swift Package Manager

Este proyecto aplica una estructura modular, dividiendo la aplicación en **módulos funcionales** distribuidos en paquetes independientes utilizando **Swift Package Manager (SPM)**.

Cada módulo encapsula su lógica de negocio, presentación, navegación y dependencias específicas. Esto permite:

* Desacoplamiento entre features
* Builds más rápidos gracias a la compilación incremental por módulo
* Mejor testabilidad y reusabilidad
* Posibilidad de compartir features entre proyectos o equipos

### Estructura de Módulos (ejemplo):

```
RickAndMortyTCA/
├── Presentation/              # Capas de UI y coordinadores por feature
├── Data/                      # Implementaciones de repositorios y clientes
├── Domain/                   # Entidades, casos de uso, protocolos
├── RickAndMortyApp/
│   ├── Resources/             # Recursos de la app principal
│   ├── Compositon Root/       # Inyección de dependencias
│   ├── AppCoordinator/        # Coordinador principal de navegación
│   ├── RickAndMortyApp.swift  # Punto de entrada (estructura App)
│   ├── Info.plist
│   └── RickAndMortyApp.entitlements
├── RickAndMortyAppTests/     # Tests de lógica
├── RickAndMortyAppUITests/   # Tests de interfaz
├── Frameworks/               # Frameworks externos si aplica
```

Cada carpeta representa un **target independiente** que se registra y consume a través de SPM en el `Package.swift`. La navegación entre features se realiza de forma desacoplada mediante coordinadores y estados observables, facilitando un crecimiento escalable de la aplicación.

---

## Descripción del Proyecto TCA

RickAndMortyTCA es una aplicación de ejemplo para iOS construida usando **SwiftUI** y **The Composable Architecture (TCA)**. El objetivo de este proyecto es demostrar una arquitectura escalable, testeable y modular consumiendo una **API GraphQL pública** (Rick and Morty API) para mostrar una lista paginada de personajes y sus vistas de detalle.

La arquitectura está estrictamente basada en los principios de TCA, ofreciendo una clara gestión de estado, características composables y mejor capacidad de prueba.

### Funcionalidades del Proyecto
Este proyecto implementa las siguientes características principales:

- Visualización de una lista de personajes obtenidos desde una **API GraphQL pública**.
- Cada personaje presenta información clave: **nombre**, **estado** (vivo, muerto, desconocido), **especie**, e **imagen**.
- Funcionalidad de **actualización manual** de la lista para obtener los datos más recientes.
- **Paginación automática**, permitiendo cargar grandes volúmenes de personajes de forma eficiente.
- Experiencia fluida y modular gracias a una **arquitectura composable** basada en **TCA (The Composable Architecture)**, que favorece la escalabilidad, testabilidad y separación de responsabilidades.
 
---

## Guía de Instalación

### Requisitos

* Xcode 14.0 o superior
* iOS 16.0+
* Swift Package Manager (SPM)

### 1. Clonar el repositorio

```bash
git clone https://github.com/nelsonPena/GraphQLCharacters-TCA-TechTest.git
cd RickAndMortyTCA
```
