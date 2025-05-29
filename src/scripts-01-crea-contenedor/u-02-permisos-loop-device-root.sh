#@Autor: Martinez Martinez Francisco David
#@Fecha creación: 27/05/2024
#@Descripción: CRearon los dicos virtuales para la BD del Proyecto FInal

#!/bin/bash

echo "========== Asignando permisos y propietario al punto de montaje =========="

# Variables base
diplo_dir="/unam/diplo-bd"
default_disk_number="04"

# Preguntar por el número del disco
read -p "¿Qué número de directorio datafile configurar? [Default: $default_disk_number]: " disk_number
disk_number="${disk_number:-$default_disk_number}"

# Construir ruta del punto de montaje
mount_dir="${diplo_dir}/pet-care-disks/datafile-d${disk_number}"

# Verificar existencia del directorio
if [ ! -d "$mount_dir" ]; then
  echo "El directorio $mount_dir no existe. ¿Estás seguro de haber montado el disco?"
  exit 1
fi

# Asignar permisos y propietario
echo "Asignando permisos 777 y propietario oracle:oinstall a $mount_dir"
sudo chmod 777 "$mount_dir"
sudo chown oracle:oinstall "$mount_dir"

echo "Listo. Verifica con: ls -ld $mount_dir"
ls -l $diplo_dir/pet-care-disks/
