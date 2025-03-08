#!/bin/bash

#URL de la web elegida
URL="https://www.paulinacocina.net/pisco-sour-peruano/32446"

#Achivo para guardar el texto de la web
OUTPUT_FILE="texto_web.txt"

#Verificar si se proporciono una palabra como argumento 
if [ -z "$1" ]; then
   echo "Por favor, proporciona una palabra como argumento."
   exit 1
fi

#Palabra a buscar
WORD="$1"

#Descargar el contenido de la web
curl -s "$URL" -o "$OUTPUT_FILE"

#Buscar la palabra en el output file
NUM_MATCHES=$(grep -o "$WORD" "$OUTPUT_FILE" | wc -l)

if [ "$NUM_MATCHES" -eq 0 ]; then
   echo "No se ha encontrado la palabra \"$WORD\""
else
FIRST_OCURRENCE=$(grep -o "$WORD" "$OUTPUT_FILE" | head -n 1 | cut -d: -f1)
   echo "La palabra \"$WORD\" aparece $NUM_MATCHES veces"
   echo "Aparece por primera vez en la linea $FIRST_OCURRENCE"
fi
