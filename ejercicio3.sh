#!/bin/bash

# Definir texto por defecto
DEFAULT_TEXT="Que me gusta la bash!!!"

# Usar el texto proporcionado como argumento, o el texto por defecto si esta vacio 
TEXT="${1:-$DEFAULT_TEXT}"

#Crear los directorios
mkdir -p foo/dummy foo/empty

#Crear el archivo file1.txt con el texto que se le proporcione
echo "$TEXT" > foo/dummy/file1.txt

#Volcar el contenido de file1 a file2
cat foo/dummy/file1.txt > foo/dummy/file2.txt

#Mover file2 a la carpeta empty
mv foo/dummy/file2.txt foo/empty/

# Mostrar resultados
echo "Estructura creada con éxito:"
find foo

echo "Contenido de file1.txt:"
cat foo/dummy/file1.txt

echo "Contenido de file2.txt:"
cat foo/empty/file2.txt
