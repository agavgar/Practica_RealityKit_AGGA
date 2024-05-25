**Práctica para el módulo Seguridad de Keepcoding.**

Práctica de desarrollo seguro en iOS. Patrón de diseño MVVM, realizado en swiftUI. Protección contra un ataque MITM utilizando SSLPinning y claves públicas, ofuscacion de claves además de encriptación AES - 24Bits. También encriptación de URLs, uso del CriptoKit. FaceID para autenticación.

**Resultado: WIP**

![IMG_9763-2](https://github.com/agavgar/Practica_Seguridad_AGGA/assets/98350985/1687a809-d51a-4444-819b-bb79c1087984)
![IMG_9764-2](https://github.com/agavgar/Practica_Seguridad_AGGA/assets/98350985/c5820a67-aadc-4b6c-8503-c6349559a1fd)
![IMG_9765-2](https://github.com/agavgar/Practica_Seguridad_AGGA/assets/98350985/5368eb5a-a71d-4218-9248-77bf5e4ef248)
![IMG_9766-2](https://github.com/agavgar/Practica_Seguridad_AGGA/assets/98350985/4e218066-1e8a-4521-9393-e07ad9ec4d72)
![IMG_9768-2](https://github.com/agavgar/Practica_Seguridad_AGGA/assets/98350985/36ec78b1-95a9-4c4b-8a74-b81a44ceddfb)

**Breve descripción**

La realización de la práctica ha empezado por desarrollo en cascada inversa. Inicio en el Backend y finalizando en las vistas. En esta ocasión API de Pokemon, más sencillo que Marvel cuyo unica dificultad reside en la implementación de una variable que decide cuantos pokemons e items vas a querer en la aplicación. Luego se ha realizado la encriptacion de los Endpoints (url de la API) por medio de CryptoKit y usando la función AES realizadno los padding necesarios para convertir en cadena de bits y encriptarlo por rondas de manera simétrica. Protección contra MITM a base de SSLPinning de clave pública con su encriptación. También uso de metodo de ofuscación para porteger la public key del servidor. Añadido método de autenticación con FaceID.

**Guía de instalación**

Simplemente debemos descargarnos el prouyecto en ZIP o en HTTP y clonar el repositorio. Luego ejecutar el archivo del proyecto de xCode y con pulsar al play tendremos la aplicación funcionando. Solo usuarios con MAC y xCode instalado. Pruebas de ataques de MITM con ZAP Proxy.

**Experiencia**

Ha sido un módulo interesantísimo, la práctica creo que ha quedado segura y ha sido muy divertida de hacer. Hemos dado mucha teoría sobre las categrorías de seguridad en las aplicaciones. Ha sido muy divertiedo y muy instructivo como un ataque puede dejar expuesto tus datos, el de tus usuarios, todas las claves y las autenticaciones. Te das cuenta que hackear una aplicación móvil es muy sencillo de hacer y existen muchas herramientas para ello. Ha sido muy divertido diseñar un  metodo de ofuscación, tener que conseguir encriptar toda la información que pueda ser sensible y proteger a las variables ya que existen ataques a Strings que devuelven todas la información importante.
