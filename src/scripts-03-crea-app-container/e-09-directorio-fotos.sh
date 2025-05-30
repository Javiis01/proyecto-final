#!/bin/bash

# Script interactivo para crear carpeta y mover imagen con permisos
# Autor: Martinez Martinez Francisco David
# Fecha: 30/05/2025

# Paso 1: Preguntar por directorio base
read -p "Ingrese el directorio base (por defecto: /unam/diplo-bd/): " BASE_DIR

# Si el usuario no ingresa nada, usar el valor por defecto
if [ -z "$BASE_DIR" ]; then
    BASE_DIR="/unam/diplo-bd/"
fi

# Asegurar que el directorio termina con /
[[ "${BASE_DIR}" != */ ]] && BASE_DIR="${BASE_DIR}/"

# Ruta final del directorio pet-care-fotos
TARGET_DIR="${BASE_DIR}pet-care-fotos"

# Paso 2: Crear directorio
echo "Creando directorio: $TARGET_DIR"
mkdir -p "$TARGET_DIR"

# Paso 3: Cambiar permisos y propietario
chmod 777 "$TARGET_DIR"
chown oracle:oinstall "$TARGET_DIR"

# Paso 4: Mover perro1.png (debe estar junto al script)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIG_IMAGE="${SCRIPT_DIR}/perro1.png"

if [ ! -f "$ORIG_IMAGE" ]; then
    echo "Error: No se encontró perro1.png en el mismo directorio del script."
    exit 1
fi

echo "Moviendo perro1.png a $TARGET_DIR"
cp "$ORIG_IMAGE" "$TARGET_DIR"

# Paso 5: Aplicar permisos a la imagen
chmod 777 "${TARGET_DIR}/perro1.png"
chown oracle:oinstall "${TARGET_DIR}/perro1.png"

echo "Imagen movida y permisos aplicados correctamente."
