#!/bin/bash
#@Autor:          Javier Carranza Mendoza
#@Fecha creación:  19/12/2024
#@Descripción:  Creación del diccionario de datos

echo "Creación del diccionario de datos"

echo "Creando archivo de bitacoras"
mkdir /tmp/dd-logs


#perl -I $ORACLE_HOME/rdbms/admin \
#$ORACLE_HOME/rdbms/admin/catcdb.pl \
#--logDirectory /tmp/dd-logs \
#--logFilename dd.log \
#--logErrorsFilename dderror.log


echo "Listo!!  Verficar la correcta creación del DD"

sqlplus -s sys/system2 as sysdba << EOF
set serveroutput on
exec dbms_dictionary_check.full
EOF

echo "Listo"


#Conclusiones
 #   ¿El ejercicio aportó y/o mejoró la comprensión del concepto ?
 #   Aprendi que hay archivos de pearl que nos ayudan a ir instalando lo necesario para que funcione la base de datos

 #   Problemas identificados durante su elaboración así como la forma en la que se solucionaron
 #   Ninguno

 #   Comentarios, sugerencias.
 #   Que nos pasen algun link o donde dice lo necesario para generar una nueva BD
