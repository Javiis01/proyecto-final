--@Autor:          Jorge A. Rodriguez C
--@Fecha creación:  dd/mm/yyyy
--@Descripción: Creación de una PDB

prompt 0. Generando spool
spool jcm-s-08-crea-pdb-ordinario-spool.txt

Prompt Conectando como sys
connect sys/system2 as sysdba

Prompt creando PDB
create pluggable database jcmdiplo_s2
  admin user jcm_admin identified by jcm_admin
  path_prefix = '/opt/oracle/oradata/FREE'
  file_name_convert = ('/pdbseed/', '/jcmdiplo_s2/');

Prompt abrir la PDB
alter pluggable database jcmdiplo_s2 open;

Prompt guardar el estado de la PDB
alter pluggable database jcmdiplo_s2 save state;

spool off 
prompt Listo!.