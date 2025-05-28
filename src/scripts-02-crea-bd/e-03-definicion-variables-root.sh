#@Autor: Martinez Martinez Francisco David
#@Fecha creación: 27/05/2024
#@Descripción: Definicion de Variables de Entorno para Oracle

#!/bin/bash

# Verifica si el script se está ejecutando como root
if [ "$(id -u)" -ne 0 ]; then
  echo "Este script debe ejecutarse como root." >&2
  exit 1
fi

# Pausa opcional para confirmación
echo "Se creará el archivo /etc/profile.d/99-custom-env.sh con las siguientes variables."
echo "Presiona Enter para continuar o Ctrl+C para cancelar..."
read

# Define el archivo de destino
DEST="/etc/profile.d/99-custom-env.sh"

# Escribe el contenido al archivo
cat > "$DEST" <<EOF
# Variables de entorno para Oracle.
export ORACLE_HOSTNAME=pet-care.fi.unam
export ORACLE_BASE=/opt/oracle
export ORACLE_HOME=\$ORACLE_BASE/product/23ai/dbhomeFree
export ORA_INVENTORY=\$ORACLE_BASE/oraInventory
export ORACLE_SID=free
export NLS_LANG=American_America.AL32UTF8
export PATH=\$ORACLE_HOME/bin:\$PATH
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:\$LD_LIBRARY_PATH

# Alias globales
alias sqlplus='rlwrap sqlplus'
EOF

echo "Archivo creado exitosamente en $DEST"
echo "Reiniciar el COntenedor"
