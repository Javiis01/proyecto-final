shutdown immediate;
startup mount;
alter database archivelog;
alter database open;
show parameter db_recovery_file_dest;
alter system set db_recovery_file_dest_size = 20G scope=both;
--crear la carpeta y darle permisos
alter system set db_recovery_file_dest = '/unam/diplo-bd/pet-care-fast-recovery-area' SCOPE=BOTH;
alter system set db_flashback_retention_target = 4320 scope=both; -- 3 días = 4320 minutos
alter database flashback on;






--========================================= rman =========================================

Un miembro de los Redo Logs deberá ubicarse en la FRA

ALTER DATABASE ADD LOGFILE MEMBER '/unam/diplo-bd/pet-care-fast-recovery-area/fra_redo01.log' TO GROUP 1;
ALTER DATABASE ADD LOGFILE MEMBER '/unam/diplo-bd/pet-care-fast-recovery-area/fra_redo02.log' TO GROUP 2;
ALTER DATABASE ADD LOGFILE MEMBER '/unam/diplo-bd/pet-care-fast-recovery-area/fra_redo03.log' TO GROUP 3;



Una copia de los archived Redo Logs deberá ubicarse en la FRA

alter system set log_archive_max_processes=5 scope=spfile;
ALTER SYSTEM SET log_archive_dest_1='LOCATION=USE_DB_RECOVERY_FILE_DEST' SCOPE=BOTH;
alter system set log_archive_format='arch_free_%t_%s_%r.arc' scope=spfile;
alter system set log_archive_min_succeed_dest=1 scope=spfile;


--● Una copia de los backups tipo BackupSet deberá ubicarse en la FRA, otra copia fuera de la FRA
--LOCAL


RUN {
  ALLOCATE CHANNEL fra_ch1 DEVICE TYPE DISK FORMAT '%U';
  ALLOCATE CHANNEL ext_ch1 DEVICE TYPE DISK FORMAT '/unam/diplo-bd/respaldo-pet-care/%U';

  BACKUP AS BACKUPSET DATABASE PLUS ARCHIVELOG;

  RELEASE CHANNEL fra_ch1;
  RELEASE CHANNEL ext_ch1;
}