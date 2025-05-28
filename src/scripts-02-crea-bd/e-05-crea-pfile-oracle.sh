#@Autor: JAvier Carranza Mendoza
#@Fecha creación: <Fecha de creación> 
#@Descripción: Creacion de los pfile

#!/bin/bash

echo "Creando un archivo de parametros básico"

pfile=$ORACLE_HOME/dbs/init${ORACLE_SID}.ora

echo "Validando la existencia del archivo de parámetros"
if [ -f "${pfile}" ]; then
  read -p "El archivo ya existe [Enter] para sobrescribir, Ctrl -C Cancelar"
fi;

echo " 1. Creando el archivo de parámetros"
echo \
"
  db_name=${ORACLE_SID}
  memory_target=768M
  control_files=(
    /unam/diplo-bd/pet-care-disks/d01/app/oracle/oradata/${ORACLE_SID^^}/control01.ctl,
    /unam/diplo-bd/pet-care-disks/d02/app/oracle/oradata/${ORACLE_SID^^}/control02.ctl,
    /unam/diplo-bd/pet-care-disks/d03/app/oracle/oradata/${ORACLE_SID^^}/control03.ctl
  )
  db_domain=fi.unam
  enable_pluggable_database=true
">${pfile}

echo "Listo"
echo "Comprobando la existencia y contenido del PFILE"
echo ""
cat ${pfile}
