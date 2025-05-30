--@Autor: Martinez Martinez Francisco David
--@Fecha creación: 27/05/2025
--@Descripción: Creación del App Container y Llamado a creacion de tablas e inserts

connect sys/system2 as sysdba

Prompt 1. Apagando la instancia
shutdown immediate

Prompt 2. Iniciando en modo mount
startup mount

Prompt 3. Habilitar el modo archive
alter database archivelog;

Prompt 4. Abrir la BD  para comprobar configuración
alter database open;

Prompt 5. Comprobando resultados
archive log list


ALTER SYSTEM SET DB_RECOVERY_FILE_DEST = '/unam/diplo-bd/pet-care-fast-recovery-area' SCOPE=BOTH;

ALTER SYSTEM SET DB_RECOVERY_FILE_DEST_SIZE = 30G SCOPE=BOTH;