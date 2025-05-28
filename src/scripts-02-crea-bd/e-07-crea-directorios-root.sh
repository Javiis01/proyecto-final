#@Autor: Martinez Martinez Francisco David
#@Fecha creación: 27/05/2025
#@Descripción: Creacion de los directorios de los datafiles

#!/bin/bash
echo "Verificando existencia de directorio para data files"

if [ -d "/opt/oracle/oradata/${ORACLE_SID^^}" ]; then
  echo "Directorio para data files ya existe, se omite creación"
else
  echo "1. Creando directorios para data files de cdb$root"  
  cd /opt/oracle
  mkdir -p oradata/${ORACLE_SID^^}
  chown -R oracle:oinstall oradata
  chmod -R 750 oradata  
fi;

echo "Verificando existencia de directorio para pdb$seed"
if [ -d "/opt/oracle/oradata/${ORACLE_SID^^}/pdbseed" ]; then
  echo "Directorio para data files ya existe, se omite creación"
else
  echo "1. Creando directorios para data files de pdb$seed"  
  cd /opt/oracle/oradata/${ORACLE_SID^^}
  mkdir  pdbseed
  chown  oracle:oinstall pdbseed
  chmod  750 pdbseed  
fi;


echo "3. Creando directorios para Redo Logs y control files"

#d01
if [ -d "/unam/diplo-bd/pet-care-disks/d01/app/oracle/oradata/${ORACLE_SID^^}" ]; then
  echo "Directorio para data files ya existe, se omite creación"
else
  echo "1. Creando directorios para Redo Logs y control files en d01"  
  cd /unam/diplo-bd/pet-care-disks/d01
  mkdir -p app/oracle/oradata/${ORACLE_SID^^}
  chown -R oracle:oinstall app
  chmod -R 750 app  
fi;

#d02
if [ -d "/unam/diplo-bd/pet-care-disks/d02/app/oracle/oradata/${ORACLE_SID^^}" ]; then
  echo "Directorio para data files ya existe, se omite creación"
else
  echo "1. Creando directorios para Redo Logs y control files en d02"
  cd /unam/diplo-bd/pet-care-disks/d02
  mkdir -p app/oracle/oradata/${ORACLE_SID^^}
  chown -R oracle:oinstall app
  chmod -R 750 app  
fi;

#d03
if [ -d "/unam/diplo-bd/pet-care-disks/d03/app/oracle/oradata/${ORACLE_SID^^}" ]; then
  echo "Directorio para data files ya existe, se omite creación"
else
  echo "1. Creando directorios para Redo Logs y control files en d03"
  cd /unam/diplo-bd/pet-care-disks/d03
  mkdir -p app/oracle/oradata/${ORACLE_SID^^}
  chown -R oracle:oinstall app
  chmod -R 750 app  
fi;

echo "4. Eliminando archivos de intentos anteriores en caso de existir "
read -p "Presionar [Enter] para continuar, Ctrl -C para cancelar"

echo "limpiando datafiles de cdb$rooot"
cd /opt/oracle/oradata/${ORACLE_SID^^}
rm -f *.dbf

echo "limpiando datafiles de pdb$seed"
cd /opt/oracle/oradata/${ORACLE_SID^^}/pdbseed
rm -f *.dbf

echo "limpiando control files y redo logs"
#d01
cd  /unam/diplo-bd/pet-care-disks/d01/app/oracle/oradata/${ORACLE_SID^^}
rm -f *.log *.ctl
#d02
cd  /unam/diplo-bd/pet-care-disks/d02/app/oracle/oradata/${ORACLE_SID^^}
rm -f *.log *.ctl
#d03
cd  /unam/diplo-bd/pet-care-disks/d03/app/oracle/oradata/${ORACLE_SID^^}
rm -f *.log *.ctl


echo "5. Mostrando directorio de data files"
ls -l /opt/oracle/oradata

echo "Mostrando directorios para control files y Redo Logs"
ls -l /unam/diplo-bd/pet-care-disks/d0*/app/oracle/oradata