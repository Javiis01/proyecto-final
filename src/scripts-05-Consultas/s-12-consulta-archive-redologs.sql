--@Autor: Martinez Martinez Francisco David
--@Fecha creación: 27/05/2025
--@Descripción: 10. Preparar una consulta que muestre la distribución de todos sus datafiles

Prompt ===> Conectandose como sys
connect sys/system2 as sysdba

Prompt ===> Conectandonos al container
alter session set container = cdb$root;

Prompt ==> definiendo valores
set linesize window
--col destination format a50
--col error format a30
col member format a70 

Prompt ==> consulta que muestre las ubicaciones de los grupos de Redo Logs <===
SELECT group#, member
FROM v$logfile;
/*SELECT DEST_ID,
       STATUS,
       DESTINATION,
       TARGET,
       ARCHIVER,
       ERROR
FROM   V$ARCHIVE_DEST
WHERE  STATUS = 'VALID' AND DESTINATION IS NOT NULL;*/