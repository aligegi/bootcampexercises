#!/bin/bash

# Verificar que se pasen exactamente dos parametros
if [ "$#" -ne 2 ]; then
  echo "Se necesitan unicamente dos parametros para ejecutar este script"
  exit 1
fi

# Parametros del script
URL="$1"
WORD="$2"

# Archivo donde se guardar√el contenido de la pagina
OUTPUT_FILE="pagina_web.txt"

# Descargar el contenido de la pagina web
curl -s "$URL" -o "$OUTPUT_FILE"

# Buscar la palabra en el archivo
MATCHES=$(grep -o "$WORD" "$OUTPUT_FILE" | wc -l)

if [ "$MATCHES" -eq 0 ]; then
  # Si no se encuentra la palabra
  echo "No se ha encontrado la palabra \"$WORD\""
elif [ "$MATCHES" -eq 1 ]; then
  # Si la palabra se encuentra exactamente una vez
  FIRST_OCCURRENCE=$(grep -n "$WORD" "$OUTPUT_FILE" | head -n 1 | cut -d: -f1)
  echo "La palabra \"$WORD\" aparece 1 vez"
  echo "Aparece unicamente en la linea $FIRST_OCCURRENCE"
else
  # Si la palabra se encuentra mas de una vez
  FIRST_OCCURRENCE=$(grep -n "$WORD" "$OUTPUT_FILE" | head -n 1 | cut -d: -f1)
  echo "La palabra \"$WORD\" aparece $MATCHES veces"
  echo "Aparece por primera vez en la linea $FIRST_OCCURRENCE"
fi

