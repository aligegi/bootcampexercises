# Usar la imagen oficial de Node.js
FROM node:14

# Crear y establecer el directorio de trabajo
WORKDIR /usr/src/app

# Copiar los archivos de configuración de npm
COPY package*.json ./

# Instalar las dependencias
RUN npm install

# Copiar el resto de los archivos del proyecto, incluidas las vistas EJS
COPY . .

# Exponer el puerto 8080
EXPOSE 8080

# Comando para iniciar el servidor
CMD ["npm", "start"]
