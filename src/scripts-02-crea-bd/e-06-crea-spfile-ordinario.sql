--@Autor: Martinez Martinez Francisco David
--@Fecha creación: 27/05/2025
--@Descripción: Creación de un SPFILE

prompt 0. Generando spool
spool dmm-e-04-crea-spfile-ordinario-spool.txt

Prompt 1. Conectando como sys empleando archivo de passwords 
connect sys/Hola1234* as sysdba

Prompt  2. Creando el SPFILE a partir del PFILE
create spfile from pfile;

Prompt 3. verificando su existencia.
!ls -l ${ORACLE_HOME}/dbs/spfile${ORACLE_SID}.ora

Prompt Listo!
spool off 

exit