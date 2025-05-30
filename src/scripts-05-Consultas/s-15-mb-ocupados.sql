--@Autor: Martinez Martinez Francisco David
--@Fecha creación: 27/05/2025
--@Descripción: 10. Preparar una consulta que muestre la distribución de todos sus datafiles

Prompt ===> Conectandose como sys
connect sys/system2 as sysdba

-- Preguntar al usuario por el container (PDB) con valor por defecto CDB$ROOT
PROMPT ===> Por favor ingrese el nombre del contenedor (PDB). Por defecto: CDB$ROOT
ACCEPT pdb_name CHAR DEFAULT 'CDB$ROOT' PROMPT 'Nombre del contenedor [CDB$ROOT]: '

-- Mostrar a qué contenedor se conectará
PROMPT ===> Conectandose al contenedor &&pdb_name...
ALTER SESSION SET CONTAINER = &&pdb_name;

Prompt ==> definiendo valores
set linesize window
col owner format a30

SELECT 
  segment_type,
  SUM(bytes) / 1024 / 1024 AS size_mb
FROM 
  dba_segments
GROUP BY 
  segment_type
ORDER BY 
  size_mb DESC;
/*
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
  
*/