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

/unam/diplo-bd/pet-care-disk-images/disk-datafile-1.img /unam/diplo-bd/pet-care-disks/datafile-d01 auto  loop  0 0
/unam/diplo-bd/pet-care-disk-images/disk-datafile-2.img /unam/diplo-bd/pet-care-disks/datafile-d02 auto  loop  0 0
/unam/diplo-bd/pet-care-disk-images/disk-datafile-3.img /unam/diplo-bd/pet-care-disks/datafile-d03 auto  loop  0 0


/dev/loop1: [2050]:40370663 (/var/lib/snapd/snaps/core22_1963.snap)
/dev/loop19: [2050]:40370591 (/var/lib/snapd/snaps/spectacle_179.snap)
/dev/loop27: [2050]:3277040 (/unam/diplo-bd/pet-care-disk-images/disk-datafile-2.img)
/dev/loop17: [2050]:40377274 (/var/lib/snapd/snaps/snapd-desktop-integration_178.snap)
/dev/loop8: [2050]:40371238 (/var/lib/snapd/snaps/gnome-42-2204_202.snap)
/dev/loop25: [2050]:3277024 (/unam/diplo-bd/pet-care-disk-images/disk3.img)
/dev/loop15: [2050]:40370260 (/var/lib/snapd/snaps/snapd_23771.snap)
/dev/loop6: [2050]:40371197 (/var/lib/snapd/snaps/firmware-updater_167.snap)
/dev/loop23: [2050]:3277022 (/unam/diplo-bd/pet-care-disk-images/disk1.img)
/dev/loop13: [2050]:40370587 (/var/lib/snapd/snaps/snap-store_1248.snap)
/dev/loop4: [2050]:40371846 (/var/lib/snapd/snaps/firefox_6103.snap)
/dev/loop21: [2050]:2359543 (/unam/diplo-bd/disk-images/disk2.img)
/dev/loop11: [2050]:40370319 (/var/lib/snapd/snaps/libreoffice_342.snap)
/dev/loop2: [2050]:40377267 (/var/lib/snapd/snaps/bare_5.snap)
/dev/loop0: [2050]:40370684 (/var/lib/snapd/snaps/core22_1908.snap)
/dev/loop28: [2050]:3277041 (/unam/diplo-bd/pet-care-disk-images/disk-datafile-3.img)
/dev/loop18: [2050]:40370646 (/var/lib/snapd/snaps/snapd-desktop-integration_253.snap)
/dev/loop9: [2050]:40377272 (/var/lib/snapd/snaps/gtk-common-themes_1535.snap)
/dev/loop26: [2050]:40371407 (/var/lib/snapd/snaps/firefox_6159.snap)
/dev/loop16: [2050]:40370688 (/var/lib/snapd/snaps/snapd_24505.snap)
/dev/loop7: [2050]:40377271 (/var/lib/snapd/snaps/gnome-42-2204_176.snap)
/dev/loop24: [2050]:3277023 (/unam/diplo-bd/pet-care-disk-images/disk2.img)
/dev/loop14: [2050]:40370313 (/var/lib/snapd/snaps/snap-store_1270.snap)
/dev/loop5: [2050]:40372054 (/var/lib/snapd/snaps/firmware-updater_147.snap)
/dev/loop22: [2050]:2359544 (/unam/diplo-bd/disk-images/disk3.img)
/dev/loop12: [2050]:40370266 (/var/lib/snapd/snaps/libreoffice_344.snap)
/dev/loop3: [2050]:3277039 (/unam/diplo-bd/pet-care-disk-images/disk-datafile-1.img)
/dev/loop20: [2050]:2359542 (/unam/diplo-bd/disk-images/disk1.img)
/dev/loop10: [2050]:40370300 (/var/lib/snapd/snaps/kf5-5-110-qt-5-15-11-core22_3.snap)