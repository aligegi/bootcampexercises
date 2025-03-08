# Imagen base con el SDK para compilar el código
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copiar archivos del proyecto y restaurar dependencias
COPY . ./
RUN dotnet restore

# Compilar el proyecto
RUN dotnet publish -c Release -o /publish

# Imagen final para correr la aplicación
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /publish .

# Expone el puerto 5000 para la API
EXPOSE 5000

# Comando para ejecutar la aplicación
CMD ["dotnet", "backend.dll"]
