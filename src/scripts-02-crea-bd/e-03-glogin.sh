# @Autor: Martinez Martinez Francisco David
# @Fecha: 27/05/2025
# @Descripción: Configura glogin.sql con editor nano y prompt personalizado para SQL*Plus

#!/bin/bash

echo "moviendonos a $ORACLE_HOME/sqlplus/admin"
cd $ORACLE_HOME/sqlplus/admin

echo "Modificando glogin.sql..."
cat << 'EOC' >> glogin.sql

-- Editor por defecto
define _EDITOR=nano

-- Personalizar el prompt
define prompt_value=idle
col prompt_name new_value prompt_value
col prompt_name noprint
set heading off
set termout off
select lower(sys_context('userenv','current_user')
  ||'@'
  ||sys_context('userenv','db_name'))
as prompt_name
from dual;
set sqlprompt '&prompt_value> '
set heading on
set termout on
col prompt_name print
set trimspool on

EOC

echo "Otorgando Permisos"
chmod 755 glogin.sql
echo "Archivo glogin.sql modificado y permisos actualizados."

echo "recuerde ejecutar netca para el Listener"
echo "recuerde ejecutar netmgr para tnsnames.ora"