#@Autor: Martinez Martinez Francisco David
#@Fecha creación: 27/05/2025
#@Descripción: Creación del diccionario de datos

#!/bin/bash

echo "Creación del diccionario de datos"

echo "Creando archivo de bitacoras"
mkdir /tmp/dd-logs

echo "MOviendonos a la carpeta $ORACLE_HOME/rdbms/admin Para evitar errores"
cd  $ORACLE_HOME/rdbms/admin
pwd

echo "Ejecutando Creaccion de Diccionarios"
perl -I $ORACLE_HOME/rdbms/admin \
$ORACLE_HOME/rdbms/admin/catcdb.pl \
--logDirectory /tmp/dd-logs \
--logFilename dd.log \
--logErrorsFilename dderror.log

echo "Listo!!  Verficar la correcta creación del DD"

sqlplus -s sys/system2 as sysdba << EOF
set serveroutput on
exec dbms_dictionary_check.full
EOF

echo "Listo"
