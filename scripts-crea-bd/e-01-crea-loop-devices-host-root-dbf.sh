#@Autor: <JAvier CArranza Mendoza
#@Fecha creación: 17/12/2024
#@Descripción: CRearon los dicos virtuales para la BD

#!/bin/bash
diplo_dir="/unam/diplo-bd"

echo "1. Creando directorio disk-images"
mkdir -p "${diplo_dir}"/pet-care-disk-images

echo "2,3. Crear archivos img"
cd "${diplo_dir}/pet-care-disk-images"

if [ -f "disk-datafile-1.img" ]; then
  read -p "El archivo ya existe [Enter] para sobrescribir, Ctrl -C Cancelar"
fi;

echo "creando archivo disk-datafile-1.img"
dd if=/dev/zero of=disk-datafile-1.img bs=100M count=10

#disk-datafile-2.img
if [ -f "disk-datafile-2.img" ]; then
  read -p "El archivo ya existe [Enter] para sobrescribir, Ctrl -C Cancelar"
fi;
echo "creando archivo disk-datafile-2.img"
dd if=/dev/zero of=disk-datafile-2.img bs=100M count=10

#disk-datafile-3.img
if [ -f "disk-datafile-3.img" ]; then
  read -p "El archivo ya existe [Enter] para sobrescribir, Ctrl -C Cancelar"
fi;
echo "creando archivo disk-datafile-3.img"
dd if=/dev/zero of=disk-datafile-3.img bs=100M count=10

echo "4. Mostrando la creación de los archivos"
du -sh disk*.img 

echo "5. Creando Loop devices "

echo "Creando loop device para disk-datafile-1.img"
losetup -fP disk-datafile-1.img

echo "Creando loop device para disk-datafile-2.img"
losetup -fP disk-datafile-2.img

echo "Creando loop device para disk-datafile-3.img"
losetup -fP disk-datafile-3.img

echo "Mostrando la creación de loop devices"
losetup -a

echo "6. Dando formato ext4 a los archivos img"
echo "Dando formato ext4 a disk-datafile-1.img"
mkfs.ext4 disk-datafile-1.img

echo "Dando formato ext4 a disk-datafile-2.img"
mkfs.ext4 disk-datafile-2.img

echo "Dando formato ext4 a disk-datafile-3.img"
mkfs.ext4 disk-datafile-3.img

echo "7. Creando directorios para usarse como puntos de montaje"
mkdir -p /unam/diplo-bd/pet-care-disks/datafile-d01
mkdir -p /unam/diplo-bd/pet-care-disks/datafile-d02
mkdir -p /unam/diplo-bd/pet-care-disks/datafile-d03

echo "Listo!"

mount -o loop /dev/loop3 /unam/diplo-bd/pet-care-disks/datafile-d01
mount -o loop /dev/loop27 /unam/diplo-bd/pet-care-disks/datafile-d02
mount -o loop /dev/loop28 /unam/diplo-bd/pet-care-disks/datafile-d03
