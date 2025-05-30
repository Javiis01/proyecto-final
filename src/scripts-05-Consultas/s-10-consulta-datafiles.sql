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

Prompt ==> consulta que muestre la distribución de todos sus datafiles <===
select 
  tablespace_name, file_name, bytes / 1024 / 1024 AS size_mb, autoextensible
from dba_data_files
order by tablespace_name;
