# RickAndMortyTCA

## Introducción

Este repositorio contiene **dos implementaciones distintas** de la prueba técnica, organizadas en carpetas separadas:

* Una solución basada en **TCA (The Composable Architecture)**, una arquitectura moderna diseñada para escalar en equipos grandes y facilitar pruebas, modularización y control predecible del estado.
* Una segunda solución utilizando **Arquitectura Limpia** combinada con el patrón **MVVM**, siguiendo principios SOLID, separación por capas e inyección de dependencias tradicional.

Elegí presentar ambas alternativas para mostrar dos enfoques complementarios. He venido profundizando en TCA durante los últimos meses, ya que su uso se ha popularizado en compañías con grandes equipos y necesidades de mantenimiento a largo plazo. Por otro lado, la versión con arquitectura limpia permite mostrar un enfoque más clásico, también alineado con buenas prácticas y testabilidad.

TCA no es solo una arquitectura conceptual, sino una librería oficial mantenida por el equipo de Point-Free, disponible en: [https://www.pointfree.co/collections](https://www.pointfree.co/collections)


## Descripción del Proyecto

RickAndMortyTCA es una aplicación de ejemplo para iOS construida usando **SwiftUI** y **The Composable Architecture (TCA)**. El objetivo de este proyecto es demostrar una arquitectura escalable, testeable y modular consumiendo una **API GraphQL pública** (Rick and Morty API) para mostrar una lista paginada de personajes y sus vistas de detalle.

La arquitectura está estrictamente basada en los principios de TCA, ofreciendo una clara gestión de estado, características composables y mejor capacidad de prueba.

---

## Arquitectura: The Composable Architecture (TCA)

### Conceptos Clave

* **State (Estado)**: Fuente única de la verdad para cada dominio (feature).
* **Action (Acción)**: Enumera todas las acciones del usuario y resultados de efectos secundarios.
* **Reducer**: Funciones puras que describen cómo evoluciona el estado y qué efectos se deben producir.
* **Store**: Motor en tiempo de ejecución que mantiene el estado y procesa las acciones.

TCA promueve la **composabilidad**, **predictibilidad** y **testabilidad** al organizar las funcionalidades en una estructura predecible. Cada pantalla o función se convierte en un módulo independiente y reutilizable.

---

## CharacterListDomain: Desglose de la Funcionalidad

`CharacterListDomain` es la funcionalidad central responsable de obtener, mostrar, filtrar y paginar personajes desde la API GraphQL. También gestiona la presentación de la vista de detalle de un personaje.

### Estado

* `characterList`: Lista completa de personajes cargados.
* `filteredList`: Resultados filtrados según el texto de búsqueda.
* `isLoading`, `shouldShowError`: Indicadores derivados de `dataLoadingStatus`.
* `searchText`: Texto de búsqueda.
* `characterDetail`: Detalle del personaje seleccionado.
* `pagination`: Incluye `currentPage`, `canLoadMorePages`, `isPaginating`.

### Acciones

* `fetchCharacters`: Inicia la carga inicial o paginada de personajes.
* `fetchCharactersResponse`: Maneja el resultado de la llamada a la API.
* `setDetailView`: Abre o cierra la vista de detalle del personaje.
* `searchTextChanged`: Actualiza los resultados filtrados.
* `loadNextPage`: Carga más personajes al llegar al final de la lista.

### Dependencias

* `fetchCharactersPaginated`: Cliente API inyectado para obtener personajes paginados.
* `uuid`: Generador de identificadores únicos para cada elemento.

### Aspectos Destacados

* Composición mediante `.forEach` y `.ifLet` para reducers limitados en alcance.
* Clara separación de responsabilidades y efectos secundarios.
* Soporte de paginación sin mezclar la lógica de presentación en los reducers.
* Soporte para dependencias en vivo y simuladas (mock) para API y UUID.
* Manejo de presentaciones usando `@Presents` y `.sheet`.

---

## Ventajas de Usar TCA

1. **Testabilidad**

   TCA fomenta la escritura de pruebas unitarias aisladas y deterministas. Todas las transiciones de estado y efectos secundarios son explícitos y comprobables.

   Escenarios de prueba de ejemplo:

   * Cargar personajes iniciales.
   * Manejar paginación y anexar nuevos resultados.
   * Filtrar personajes usando texto de búsqueda.
   * Mostrar y cerrar vista de detalle al hacer tap.

2. **Modularización**

   Cada funcionalidad puede ser extraída a un módulo independiente y reutilizada en distintas apps o targets. Este proyecto separa:

   * `CharacterListDomain`
   * `CharacterItemDomain`
   * `CharacterDetailDomain`

3. **Manejo de estado predecible**

   Hay un único punto de entrada para modificar el estado: `Store.send(Action)`. No existen cambios de estado ocultos.

4. **Control claro del ciclo de vida**

   Las operaciones asincrónicas y la presentación de UI se manejan explícitamente usando `Effect`, `TaskResult` y acciones `.presented`.

---

## Guía de Instalación

### Requisitos

* Xcode 14.0 o superior
* iOS 16.0+
* Swift Package Manager (SPM)

### 1. Clonar el repositorio

```bash
[git clone https://github.com/your-username/RickAndMortyTCA.git](https://github.com/nelsonPena/GraphQLCharacters-TCA-TechTest.git)
cd RickAndMortyTCA
```
