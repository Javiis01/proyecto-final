--@Autor: Martinez Martinez Francisco David
--@Fecha creación: 27/05/2025
--@Descripción: 10. Preparar una consulta que muestre la distribución de todos sus datafiles

connect sys/system2 as sysdba

alter session set container = pet_care_ac;

set linesize window
col MEMBER format a70

select
  a.GROUP#, a.MEMBER, b.BYTES / 1024 / 1024 AS SIZE_MB, b.STATUS, 
  b.ARCHIVED, b.FIRST_TIME, b.SEQUENCE#
from v$logfile a join v$log b  
on a.GROUP# = b.GROUP#
order by a.GROUP#;