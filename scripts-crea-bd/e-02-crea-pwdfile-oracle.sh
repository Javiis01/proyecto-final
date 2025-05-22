#@Autor: <Nombre del autor o autores> 
#@Fecha creación: <Fecha de creación> 
#@Descripción: <Breve descripción del contenido del script>

#!/bin/bash

archivo_pwd="${ORACLE_HOME}/dbs/orapw${ORACLE_SID}"

echo "1. Creando un archivo de passwords usar como password Hola1234*"

echo "Verificando la existencia del archivo"
if [ -f "${archivo_pwd}" ]; then
  read -p "El archivo ya existe [Enter] para sobrescribir, Ctrl -C Cancelar"
fi;

#El password debe ser al menos de 8 caracteres con letras y caracteres
# especiales.  Por ejemplo: Hola1234*  (no debe contener el nombre de usuario)
echo "Creando archivo ${archivo_pwd}"
orapwd \
  FORCE=Y \
  FILE="${archivo_pwd}" \
  FORMAT=12.2 \
  SYS=password password=Hola1234*
  
echo "2. Verificando la existencia del archivo"
ls -l "${archivo_pwd}"
