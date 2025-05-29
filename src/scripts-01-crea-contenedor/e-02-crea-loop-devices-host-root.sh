#@Autor: Martinez Martinez Francisco David
#@Fecha creación: 27/05/2024
#@Descripción: CRearon los dicos virtuales para la BD del Proyecto FInal

#!/bin/bash
echo "========== 1. Definiendo Ruta de trabajo ========== "
diplo_dir="/unam/diplo-bd"

echo "========== 2. Creando directorio pet-care-disk-images para loop devices =========="
echo "para el proyecto"
mkdir -p "${diplo_dir}"/pet-care-disk-images

echo "========== 3. Creacion de archivos img, Estos nos permitiran simular discos fisicos ============="
echo "permitiendonos crear entornos de almacenamiento controlado"

echo "====={ 3.1. Moviendonos a ${diplo_dir}/pet-care-disk-images"
cd "${diplo_dir}/pet-care-disk-images"

echo "====={3.2.} Creando Archivos img para datafiles, control files y redologs"
echo "====={3.2.1 disk1.img}"
if [ -f "disk1.img" ]; then
  read -p "El archivo ya existe [Enter] para sobrescribir, Ctrl -C Cancelar"
fi;

echo "creando archivo disk1.img"
dd if=/dev/zero of=disk1.img bs=1M count=5120

echo "====={3.2.2 disk2.img}"
if [ -f "disk2.img" ]; then
  read -p "El archivo ya existe [Enter] para sobrescribir, Ctrl -C Cancelar"
fi;
echo "creando archivo disk2.img"
dd if=/dev/zero of=disk2.img bs=1M count=5120

echo "====={3.2.3 disk3.img}"
if [ -f "disk3.img" ]; then
  read -p "El archivo ya existe [Enter] para sobrescribir, Ctrl -C Cancelar"
fi;
echo "creando archivo disk3.img"
dd if=/dev/zero of=disk3.img bs=1M count=5120


echo "====={ 3.3.} Creando Archivos img para los tablespaces"
echo "====={3.3.1 disk-datafile-1.img}"
if [ -f "disk-datafile-1.img" ]; then
  read -p "El archivo ya existe [Enter] para sobrescribir, Ctrl -C Cancelar"
fi;

echo "creando archivo disk-datafile-1.img"
dd if=/dev/zero of=disk-datafile-1.img bs=1M count=15360

echo "====={3.3.2 disk-datafile-2.img}"
if [ -f "disk-datafile-2.img" ]; then
  read -p "El archivo ya existe [Enter] para sobrescribir, Ctrl -C Cancelar"
fi;

echo "creando archivo disk-datafile-2.img"
dd if=/dev/zero of=disk-datafile-2.img bs=1M count=15360

echo "====={3.3.3 disk-datafile-3.img}"
if [ -f "disk-datafile-3.img" ]; then
  read -p "El archivo ya existe [Enter] para sobrescribir, Ctrl -C Cancelar"
fi;

echo "creando archivo disk-datafile-3.img"
dd if=/dev/zero of=disk-datafile-3.img bs=1M count=15360

echo "========== 4. Mostrando la creación de los archivos ========="
du -sh disk*.img 


echo "=========== 5. Creando Loop devices =============="
echo "Creando loop device para disk1.img"
losetup -fP disk1.img

echo "Creando loop device para disk2.img"
losetup -fP disk2.img

echo "Creando loop device para disk3.img"
losetup -fP disk3.img

echo "Creando loop device para disk-datafile-1.img"
losetup -fP disk-datafile-1.img

echo "Creando loop device para disk-datafile-2.img"
losetup -fP disk-datafile-2.img

echo "Creando loop device para disk-datafile-3.img"
losetup -fP disk-datafile-3.img

echo "========={5.1} Mostrando la creación de loop devices"
losetup -a | grep '(/unam/diplo-bd/' | sort -V

echo "========== 6. Dando formato ext4 a los archivos img =============="
echo "Dando formato ext4 a disk1.img"
mkfs.ext4 disk1.img

echo "Dando formato ext4 a disk2.img"
mkfs.ext4 disk2.img

echo "Dando formato ext4 a disk3.img"
mkfs.ext4 disk3.img

echo "Dando formato ext4 a disk-datafile-1.img"
mkfs.ext4 disk-datafile-1.img

echo "Dando formato ext4 a disk-datafile-2.img"
mkfs.ext4 disk-datafile-2.img

echo "Dando formato ext4 a disk-datafile-3.img"
mkfs.ext4 disk-datafile-3.img

echo "========== 7. Creando directorios para usarse como puntos de montaje"
mkdir -p /unam/diplo-bd/pet-care-disks/d01
mkdir -p /unam/diplo-bd/pet-care-disks/d02
mkdir -p /unam/diplo-bd/pet-care-disks/d03
mkdir -p /unam/diplo-bd/pet-care-disks/datafile-d01
mkdir -p /unam/diplo-bd/pet-care-disks/datafile-d02
mkdir -p /unam/diplo-bd/pet-care-disks/datafile-d03

echo " ============ 8. Ejecutar Manualmente lo siguiente ================"

echo "COnsultando nuevamente los loop correspondientes"
losetup -a | grep '(/unam/diplo-bd/' | sort -V

echo "
Segun el loop para cada disk editar y ejecutar los siguientes comandos

{Cambiar los ## por el numero asignado al loop device}
mount -o loop /dev/loop16 /unam/diplo-bd/pet-care-disks/d01
mount -o loop /dev/loop17 /unam/diplo-bd/pet-care-disks/d02
mount -o loop /dev/loop18 /unam/diplo-bd/pet-care-disks/d03
mount -o loop /dev/loop19 /unam/diplo-bd/pet-care-disks/datafile-d01
mount -o loop /dev/loop20 /unam/diplo-bd/pet-care-disks/datafile-d02
mount -o loop /dev/loop21 /unam/diplo-bd/pet-care-disks/datafile-d03

nano /etc/fstab y agregar lo siguiente

#loop devices para proyecto PetCare 
/unam/diplo-bd/pet-care-disk-images/disk-datafile-1.img /unam/diplo-bd/pet-care-disks/datafile-d01 auto  loop  0 0
/unam/diplo-bd/pet-care-disk-images/disk-datafile-2.img /unam/diplo-bd/pet-care-disks/datafile-d02 auto  loop  0 0
/unam/diplo-bd/pet-care-disk-images/disk-datafile-3.img /unam/diplo-bd/pet-care-disks/datafile-d03 auto  loop  0 0

/unam/diplo-bd/pet-care-disk-images/disk1.img /unam/diplo-bd/pet-care-disks/d01 auto  loop  0 0
/unam/diplo-bd/pet-care-disk-images/disk2.img /unam/diplo-bd/pet-care-disks/d02 auto  loop  0 0
/unam/diplo-bd/pet-care-disk-images/disk3.img /unam/diplo-bd/pet-care-disks/d03 auto  loop  0 0

Para corroborar que todo este bien ejecutar:
mount -a 

!Listo
Realizar las acciones que se comentan arriba en la seccion 8
"


