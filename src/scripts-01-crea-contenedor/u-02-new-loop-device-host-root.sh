#@Autor: Martinez Martinez Francisco David
#@Fecha creación: 27/05/2024
#@Descripción: CRearon los dicos virtuales para la BD del Proyecto FInal

#!/bin/bash
########################################################################

echo "========== 1. Definiendo Variables de trabajo ========== "
diplo_dir="/unam/diplo-bd"
default_disk_number="04"
default_size_gb=10

# Preguntar número del disco
read -p "¿Qué número quieres usar para el disco? [Default: $default_disk_number]: " disk_number
disk_number="${disk_number:-$default_disk_number}"

# Preguntar tamaño en GB
read -p "¿Cuántos GB quieres asignar al archivo img? [Default: $default_size_gb]: " gb_size
gb_size="${gb_size:-$default_size_gb}"
block_size="1M"
count=$((gb_size * 1024))

# Nombre de archivo y rutas
img_filename="disk-datafile-d${disk_number}.img"
img_path="${diplo_dir}/pet-care-disk-images/$img_filename"
mount_dir="${diplo_dir}/pet-care-disks/datafile-d${disk_number}"

echo "========== 2. Creando directorios necesarios =========="
mkdir -p "${diplo_dir}/pet-care-disk-images"
mkdir -p "$mount_dir"

echo "========== 3. Creación del archivo img =========="
cd "${diplo_dir}/pet-care-disk-images"

if [ -f "$img_filename" ]; then
    read -p "El archivo $img_filename ya existe. Presiona [Enter] para sobrescribir o Ctrl+C para cancelar..."
fi

echo "Creando archivo $img_filename con $gb_size GB..."
dd if=/dev/zero of="$img_filename" bs=$block_size count=$count

echo "========== 4. Mostrando la creación del archivo =========="
du -sh "$img_filename"

echo "========== 5. Creando Loop device =========="
losetup -fP "$img_filename"

echo "========== 6. Dando formato ext4 al archivo =========="
mkfs.ext4 "$img_filename"

echo "========== 7. Preguntando por el loop device asignado =========="
echo "todos los loops"
losetup -a | grep '(/unam/diplo-bd/' | sort -V
echo "loop creado"
losetup -a | grep "$img_filename"
read -p "Ingresa el loop device asignado (por ejemplo, /dev/loop22): " loopdev

echo "========== 8. Montando el loop device =========="
systemctl daemon-reload
mount -o loop "$loopdev" "$mount_dir"

echo "========== 9. Agregando entrada a /etc/fstab =========="
fstab_entry="${img_path} ${mount_dir} auto loop 0 0"

# Verificar si ya está en /etc/fstab
sudo bash -c "cat << EOF >> /etc/fstab
${fstab_entry}
EOF"

echo "========== 10. Recargando configuración del sistema de montaje =========="
systemctl daemon-reload
mount -a

echo "========== Proceso completo. Verifica con: df -h | grep datafile =========="