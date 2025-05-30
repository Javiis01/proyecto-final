--@Autor: Martinez Martinez Francisco David
--@Fecha creación: 30/05/2025
--@Descripción: COnfigurando la base de datos para el FRA

spool spool-17-archive-modo.txt

Prompt =========={ 1. Conectandose }============
connect sys/system2 as sysdba
set linesize window

Prompt =========={ 2. Apagando la instancia }============
Prompt 1. Apagando la instancia
shutdown immediate

Prompt =========={ 3. Iniciando instancia en modo mount }============
startup mount

Prompt =========={ 4. COnsultando cambios }============
prompt estado antes de abrir la BD 
alter database archivelog;

Prompt =========={ 5. Abriendo la base de datos }============
alter database open;

Prompt =========={ 6. COnsultando cambios }============
prompt estado actual del modo de archivado 
archive log list

--Prompt =========={ 7. Definiendo directorio y tamaño para la FRA }============
--ALTER SYSTEM SET DB_RECOVERY_FILE_DEST = '/unam/diplo-bd/pet-care-fast-recovery-area' SCOPE=BOTH;
--ALTER SYSTEM SET DB_RECOVERY_FILE_DEST_SIZE = 30G SCOPE=BOTH;