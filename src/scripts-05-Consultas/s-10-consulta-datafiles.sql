--@Autor: Martinez Martinez Francisco David
--@Fecha creación: 27/05/2025
--@Descripción: 10. Preparar una consulta que muestre la distribución de todos sus datafiles

Prompt ===> Conectandose como sys
connect sys/system2 as sysdba

Prompt ===> Conectandonos al container
alter session set container = pet_care_ac;

Prompt ==> definiendo valores
set linesize window
col tablespace_name format a20
col file_name format a70
col pdb_name format a20
Prompt ==> consulta que muestre la distribución de todos sus datafiles <===
/*
select 
  tablespace_name, file_name, bytes / 1024 / 1024 AS size_mb, autoextensible
from cdb_data_files
order by tablespace_name;
*/

SELECT 
  vc.name AS pdb_name,
  df.tablespace_name,
  df.file_name,
  ROUND(df.bytes / 1024 / 1024, 2) AS size_mb,
  df.autoextensible
FROM 
  cdb_data_files df
JOIN 
  v$containers vc
  ON df.con_id = vc.con_id
ORDER BY 
  vc.name, df.tablespace_name;