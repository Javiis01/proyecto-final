--@Autor: Martinez Martinez Francisco David
--@Fecha creación: 27/05/2025
--@Descripción: Creación del App Container y Llamado a creacion de tablas e inserts

Prompt 0. Spool
spool spool-18-fast-recovery-area.txt

Prompt 1. Conectandose a sys
connect sys/system2 as sysdba

--whenever sqlerror exit rollback;
set linesize window

Prompt 2. Vericando el área de FRA 
show parameter db_recovery

Prompt 2.1. Especificando ubicación y tamaño de la FRA 
-- Se debe crear el directorio previamente
-- mkdir pet-care-fast-recovery-area
-- chmod 777 pet-care-fast-recovery-area
-- chown oracle:oinstall pet-care-fast-recovery-area
alter system set db_recovery_file_dest_size=30G scope=both;
alter system set db_recovery_file_dest='/unam/diplo-bd/pet-care-fast-recovery-area' scope=both;

Prompt 2.2 Vericando el área de FRA 
show parameter db_recovery

Prompt 2.3 Reiniciando instancia
shutdown immediate;
startup mount;

Prompt 3. Habilitar Flashback por al menos 3 días
ALTER SYSTEM SET DB_FLASHBACK_RETENTION_TARGET=4320 SCOPE=BOTH;
ALTER SYSTEM SET UNDO_RETENTION=4320 SCOPE=BOTH;

Prompt 4. Habilitadn Flash
ALTER DATABASE FLASHBACK ON;
ALTER DATABASE OPEN;

Prompt 5. Verificando que la base de datos este en modo flashback
select flashback_on from v$database;

Prompt 6.Mostrar el tiempo de retención 
show parameter undo_ret;

Prompt 7. Un miembro de los Redo Logs en la FRA
ALTER DATABASE ADD LOGFILE MEMBER '/unam/diplo-bd/pet-care-fast-recovery-area/fra_redo01.log' TO GROUP 1;
ALTER DATABASE ADD LOGFILE MEMBER '/unam/diplo-bd/pet-care-fast-recovery-area/fra_redo02.log' TO GROUP 2;
ALTER DATABASE ADD LOGFILE MEMBER '/unam/diplo-bd/pet-care-fast-recovery-area/fra_redo03.log' TO GROUP 3;
ALTER DATABASE DROP LOGFILE MEMBER '/unam/diplo-bd/pet-care-fast-recovery-area/redo01.log';

Prompt 8. Archived Redo Logs en la FRA
ALTER SYSTEM SET LOG_ARCHIVE_DEST_1='LOCATION=USE_DB_RECOVERY_FILE_DEST' SCOPE=BOTH;

Prompt 9 Corroborando 
col member format a70
SELECT GROUP#, MEMBER 
FROM V$LOGFILE
ORDER BY GROUP#;

Prompt 10. Abriendo las PDBS

Prompt 10.1 Abriendo pet_care_ac
ALTER PLUGGABLE DATABASE pet_care_ac OPEN;

Prompt 10.2 Abriendo pet_care_norte
ALTER PLUGGABLE DATABASE pet_care_norte OPEN;

Prompt 10.3 Abriendo pet_care_sur
ALTER PLUGGABLE DATABASE pet_care_sur OPEN;

spool off
