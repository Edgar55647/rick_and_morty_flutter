# Rick and Morty Flutter App

¡Bienvenido a la app de Rick and Morty! 🚀  
Esta es una aplicación móvil creada con **Flutter** que consume la **API pública de Rick and Morty** para mostrar una lista de personajes, sus detalles y una sección de favoritos.

## 🚀 **¿Cómo ejecutar la app?**

### 1. Requisitos previos

Asegúrate de tener estas herramientas listas en tu máquina:

- **Flutter**: Si no lo tienes, puedes instalarlo desde aquí: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install).
- **Dart SDK**: Viene con Flutter.
- **Un dispositivo o emulador** Android o iOS para ejecutar la app.

### 2. Clona el repositorio

Lo primero es obtener el código. Solo tienes que clonar el repositorio:

git clone https://github.com/tu-usuario/rick_and_morty_flutter.git


--Características principales--

-Pantalla de inicio: Muestra una lista de los personajes de Rick and Morty.
-Pantalla de detalles: Toca un personaje para ver más detalles sobre él.
-Pantalla de favoritos: Puedes marcar a tus personajes favoritos y verlos en una pantalla separada.
-Búsqueda: Encuentra a cualquier personaje por su nombre, en tiempo real.

--Tecnologías que usamos--

-Flutter: El framework para construir apps nativas en Android e iOS.
-Riverpod: Para manejar el estado de la app de forma eficiente.
-Cached Network Image: Optimiza la carga de las imágenes de los personajes, almacenándolas en caché.
-Rick and Morty API: Es la fuente de todos los datos de personajes que usamos.

-- Decisiones técnicas --

-Riverpod: Elegí usar Riverpod para gestionar el estado, ya que es más fácil de usar que Provider, y tiene más flexibilidad cuando se trata de manejar datos asíncronos como los que obtenemos de la API.
-Cacheo de imágenes: Usé cached_network_image para mejorar el rendimiento al cargar imágenes. Esto evita que la app descargue las mismas imágenes cada vez que se accede a ellas.
-Transiciones suaves: Agregué una animación de transición slide + fade al navegar entre la pantalla principal y la de favoritos, para hacer la experiencia más fluida.

--Flujo de la app--

-Pantalla de inicio: Se muestra una lista con todos los personajes de la serie.
-Búsqueda: Puedes buscar por nombre para encontrar a cualquier personaje.
-Favoritos: Los personajes favoritos se pueden ver en una pantalla especial, donde los puedes marcar tocando el ícono de corazón.
-Transiciones: Cuando navegas entre pantallas, las animaciones de entrada y salida son suaves para que la experiencia de usuario sea agradable.

--Notas adicionales--
-La app está diseñada para Android pero puedes correrla también en iOS sin problemas.
-No hay backend en esta app. Todos los datos vienen de la API pública de Rick and Morty.

 --Posibles mejoras para el futuro--

-Modo oscuro: Implementar soporte para modo oscuro en la app.
-Persistencia de favoritos: Guardar los favoritos para que no se pierdan si cierras la app.
-Filtros adicionales: Poder filtrar por estado o especie de los personajes.

```bash
