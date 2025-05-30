#!/bin/bash

# Preguntar ruta base, valor por defecto: /unam/diplo-bd/
read -p "Ingrese la ruta base donde se creará el directorio [/unam/diplo-bd/]: " BASE_DIR
BASE_DIR=${BASE_DIR:-/unam/diplo-bd/}

# Asegura que la ruta termine en /
[[ "${BASE_DIR}" != */ ]] && BASE_DIR="${BASE_DIR}/"

# Verificar que la ruta base existe
if [ ! -d "$BASE_DIR" ]; then
    echo "Error: La ruta base '$BASE_DIR' no existe. Abortando."
    exit 1
fi

# Preguntar nombre del directorio, por defecto: pet-care-fast-recovery-area
read -p "Ingrese el nombre del directorio [pet-care-fast-recovery-area]: " DIR_NAME
DIR_NAME=${DIR_NAME:-pet-care-fast-recovery-area}

# Ruta final completa
FULL_PATH="${BASE_DIR}${DIR_NAME}"

# Crear directorio si no existe
if [ ! -d "$FULL_PATH" ]; then
    echo "Creando directorio: $FULL_PATH"
    mkdir -p "$FULL_PATH"
else
    echo "El directorio ya existe: $FULL_PATH"
fi

# Asignar permisos y propietario
cd "$BASE_DIR"
chmod 777 "$DIR_NAME"
chown oracle:oinstall "$DIR_NAME"

echo " Listo: $FULL_PATH creado y configurado correctamente."
ls -l "$BASE_DIR"