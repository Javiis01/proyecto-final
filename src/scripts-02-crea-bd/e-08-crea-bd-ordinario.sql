--@Autor: Martinez Martinez Francisco David
--@Fecha creación: 27/05/2025
--@Descripción: Creación de una CDB


prompt 0. Generando spool
spool jcm-e-06-crea-bd2-ordinario-spool.txt

Prompt conectando como SYS empleando archivo de passwords.
connect sys/Hola1234* as sysdba

Prompt iniciando en modo nomount
startup nomount

prompt 1.  Ejecutar la instrucción create database
whenever sqlerror exit rollback

create database free
  user sys identified by system2
  user system identified by system2
  logfile group 1 (
    '/unam/diplo-bd/pet-care-disks/d01/app/oracle/oradata/FREE/redo01a.log',
    '/unam/diplo-bd/pet-care-disks/d02/app/oracle/oradata/FREE/redo01b.log',
    '/unam/diplo-bd/pet-care-disks/d03/app/oracle/oradata/FREE/redo01c.log') size 50m blocksize 512,
  group 2 (
    '/unam/diplo-bd/pet-care-disks/d01/app/oracle/oradata/FREE/redo02a.log',
    '/unam/diplo-bd/pet-care-disks/d02/app/oracle/oradata/FREE/redo02b.log',
    '/unam/diplo-bd/pet-care-disks/d03/app/oracle/oradata/FREE/redo02c.log') size 50m blocksize 512,
  group 3 (
    '/unam/diplo-bd/pet-care-disks/d01/app/oracle/oradata/FREE/redo03a.log',
    '/unam/diplo-bd/pet-care-disks/d02/app/oracle/oradata/FREE/redo03b.log',
    '/unam/diplo-bd/pet-care-disks/d03/app/oracle/oradata/FREE/redo03c.log') size 50m blocksize 512
  maxloghistory 1
  maxlogfiles 16
  maxlogmembers 3
  maxdatafiles 1024
  character set AL32UTF8
  national character set AL16UTF16
  extent management local
    datafile '/opt/oracle/oradata/FREE/system01.dbf'
      size 500m autoextend on next 10m maxsize 11G
  sysaux datafile '/opt/oracle/oradata/FREE/sysaux01.dbf'
    size 300m autoextend on next 10m maxsize 11G
      default tablespace users
  datafile '/opt/oracle/oradata/FREE/users01.dbf'
    size 50m autoextend on next 10m maxsize 11G
      default temporary tablespace tempts1
  tempfile '/opt/oracle/oradata/FREE/temp01.dbf'
    size 20m autoextend on next 1m maxsize 11G
  undo tablespace undotbs1
    datafile '/opt/oracle/oradata/FREE/undotbs01.dbf'
      size 100m autoextend on next 5m maxsize 11G
  enable pluggable database
    seed
    file_name_convert = ('/opt/oracle/oradata/FREE',
                          '/opt/oracle/oradata/FREE/pdbseed')
    system datafiles size 250m autoextend on next 10m maxsize 11G
    sysaux datafiles size 200m autoextend on next 10m maxsize 11G
  local undo on
;

prompt 2. Homologando passwords

alter user sys identified by system2;
alter user system identified by system2;
spool off 
prompt Listo!.
exit
