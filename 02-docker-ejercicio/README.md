# Ejercicio 1: Dockerización de la aplicación en lemoncode-challenge

## Pasos para ejecutar el proyecto

1. **Crear network**:
   - Crear la network lemoncode-challenge
   - Cambiar en el codigo las urls del backend y el frontend para que apunten a los nombres de cada contenedor en lugar de localhost (appsettings.json y server.js)

1. **Ejecutar MongoDB**:
   - Crear un contenedor en MongoDB conectado a un volumen persistente en la ruta `/data/db`.
   (docker run -d -p 27017:27017 --name some-mongo --network lemoncode-challenge -v mongo-data:/data/db mongo:latest)
   - Crear los registros de ejemplo en MongoDB Compass.

2. **Ejecutar el Backend**:
   - Crear un Dockerfile dentro de la carpeta backend.
   - Levantar el contenedor mapeado a la network.
   docker run -d -p 5000:5000 --name topics-api --network lemoncode-challenge
   - Asegurar que el backend esta escuchando en el puerto `5000`.
   Nota: aqui tuve que corregir el mapping de la propiedad TopicName en la clase Topics para que matcheara con topicName que es la propiedad en la collection de MongoDB.

3. **Ejectuar el Frontend**:
   - Crear un Dockerfile dentro de la carpeta frontend.
   - Levantar el contenedor mapeado a la network.
   docker run -d -p 8080:8080 --name lemoncode-frontend --network lemoncode-challenge
   - Asegurar que el frontend esta mapeado al puerto `8080`.
   Nota: aqui tambien tuve que corregir el mapping de la propiedad TopicName en el view (index.ejs) para que matcheara con topicName que es la propiedad en la response del API.


---

# Ejercicio 2: Orquestación de la aplicación con Docker Compose


## Pasos para ejecutar el proyecto con Docker Compose  

1. **Configuración del archivo `docker-compose.yml`**:
  - Crear el archivo docker-compose.yml asegurando que todos componentes estan incluidos la red, el volumen, las variables de entorno y los puertos.
  - Comandos utilizados para levantar el entorno:
  docker compose build --no-cache (añadir este no cache me permitía reflejar cambios del código en el contenedor)
  docker compose up -d 
  - Comandos utilizados para parar el entorno:
  docker compose stop (para parar todos los containers a la vez) 
  docker compose stop backend/frontend/mongo (dependiendo cual quiera parar)
  - Comando para eliminar el entorno:
  docker compose down (para parar todos los containers a la vez) 
  docker compose down backend/frontend/mongo (dependiendo cual quiera eliminar)

