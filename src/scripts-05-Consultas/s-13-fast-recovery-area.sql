--@Autor: Martinez Martinez Francisco David
--@Fecha creación: 27/05/2025
--@Descripción: 10. Preparar una consulta que muestre la distribución de todos sus datafiles
Prompt ===> Conectandose como sys
connect sys/system2 as sysdba

Prompt ===> Conectandonos al container
alter session set container = pet_care_ac;

Prompt ==> definiendo valores
set linesize window

/*
Esta consulta te muestra:
  Dónde está ubicada la FRA.
  Cuánto espacio tiene asignado.
  Cuánto se está usando y cuánto podría recuperarse.
  Cuántos archivos hay dentro de la FRA.
*/
SELECT 
  name AS FRA_ubicacion,
  space_limit / 1024 / 1024 AS FRA_tamano_MB,
  space_used / 1024 / 1024 AS FRA_espacio_usado_MB,
  space_reclaimable / 1024 / 1024 AS FRA_espacio_recuperable_MB,
  number_of_files AS Archivos_en_FRA
FROM 
  v$recovery_file_dest;