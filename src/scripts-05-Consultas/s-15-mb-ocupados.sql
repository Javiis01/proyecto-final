--@Autor: Martinez Martinez Francisco David
--@Fecha creación: 27/05/2025
--@Descripción: 10. Preparar una consulta que muestre la distribución de todos sus datafiles

Prompt ===> Conectandose como sys
connect sys/system2 as sysdba

Prompt ===> Conectandonos al container
alter session set container = cdb$root;

Prompt ==> definiendo valores
set linesize window
col owner format a30

SELECT
  owner,
  segment_type,
  ROUND(SUM(bytes) / 1024 / 1024, 2) AS mb_ocupados
FROM
  dba_segments
GROUP BY
  owner, segment_type
ORDER BY
  mb_ocupados DESC;