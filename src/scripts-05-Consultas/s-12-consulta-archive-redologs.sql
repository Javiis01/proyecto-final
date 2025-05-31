--@Autor: Martinez Martinez Francisco David
--@Fecha creación: 27/05/2025
--@Descripción: 10. Preparar una consulta que muestre la distribución de todos sus datafiles

Prompt ===> Conectandose como sys
connect sys/system2 as sysdba

Prompt ===> Conectandonos al container
alter session set container = cdb$root;

Prompt ==> definiendo valores
set linesize window
col archivo_log format a50

Prompt ==> consulta que muestre las ubicaciones de los grupos de Redo Logs <===

SELECT
    name   AS archivo_log,
    first_time,
    next_time,
    applied,
    deleted
FROM
    v$archived_log
WHERE
    name IS NOT NULL
ORDER BY
    first_time DESC;