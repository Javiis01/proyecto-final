--@Autor: Martinez Martinez Francisco David
--@Fecha creación: 27/05/2025
--@Descripción: Preparar una consulta que muestre la distribución de todos sus datafiles

connect sys/system2 as sysdba

alter session set container = pet_care_ac;

set linesize window
col tablespace_name format a20
col file_name format a70

select 
  tablespace_name, file_name, bytes / 1024 / 1024 AS size_mb, autoextensible
from dba_data_files
order by tablespace_name;
