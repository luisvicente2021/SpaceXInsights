__SpaceXInsights__

Una app iOS que muestra datos e información sobre misiones SpaceX usando Swift, UIKit, y Swift Package Manager.

__Descripción__

SpaceXInsights es una aplicación para iOS que permite navegar por misiones de SpaceX.  
ver detalles, videos de YouTube relacionados, y artículos en web.  
La interfaz principal está hecha con UIKit y 
algunas pantallas usan SwiftUI integradas vía UIHostingController.


__Tecnologías usadas__

Swift: Lenguaje de programación principal.
UIKit + SwiftUI: UIKit para la mayoría de las pantallas, SwiftUI para la pantalla de login.  
Swift Package Manager: Para manejar dependencias.
Dependencias:  
firebase  
Realm  
Coordinators: Patrón para manejar navegación.  
API: Consume datos de SpaceX https://api.spacexdata.com/v3/launches/past  

__Características principales__

Lista de misiones SpaceX con imagen y detalles.  
Pantalla de detalle para cada misión.  
Video player para reproducir videos de YouTube.  
Navegador web embebido para artículos.  
Login con validación básica.  
Coordinador para navegación estructurada.  
Animación.  
Soporte para cargar imágenes remotas con cache simple.  


__Acceso de prueba (Firebase Auth)__  

Para probar la funcionalidad de login, puedes usar las siguientes credenciales de prueba que fueron creadas en Firebase:  
📧 Email: paco@gmail.com  
🔒 Contraseña: paco2025  


__Cómo correr el proyecto__  

Clonar el repositorio: git clone https://github.com/tu-usuario/tu-repositorio.git  
Abrir el proyecto en Xcode.  
Xcode descargará automáticamente las dependencias de Swift Package Manager.  
Construir y ejecutar en simulador o dispositivo.  

Notas  

Para el launch screen se usó una imagen  
El coordinador maneja toda la navegación, desde login hasta detalles y videos.  

__Contacto__  
 Luis Vicente  
