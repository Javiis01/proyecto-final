--@Autor: Martinez Martinez Francisco David
--@Fecha creación: 27/05/2025
--@Descripción: Creación del App Container y Llamado a creacion de tablas e inserts


/*
Nota importante desde usuario oracle o root ejecutar los siguiente 
comandos y/o dar permisos o cambiar propietario y grupo

su -l oracle

Para los data files de la App Container
mkdir -p /unam/diplo-bd/pet-care-disks/datafile-d01/pdbseed
mkdir -p /unam/diplo-bd/pet-care-disks/datafile-d02/pdbseed
mkdir -p /unam/diplo-bd/pet-care-disks/datafile-d03/pdbseed

Para los data files de las APP PDBS
mkdir -p /unam/diplo-bd/pet-care-disks/datafile-d01/pet_care_norte
mkdir -p /unam/diplo-bd/pet-care-disks/datafile-d02/pet_care_norte
mkdir -p /unam/diplo-bd/pet-care-disks/datafile-d03/pet_care_norte

mkdir -p /unam/diplo-bd/pet-care-disks/datafile-d01/pet_care_norte
mkdir -p /unam/diplo-bd/pet-care-disks/datafile-d02/pet_care_norte
mkdir -p /unam/diplo-bd/pet-care-disks/datafile-d03/pet_care_norte
*/
Prompt 0. Generando spool  
spool dmm-e-10-app-container-spool.txt

Prompt 1. Conectandonos al CBD como sys 
connect sys/system2 as sysdba

Prompt 2. ================{ Application Container }====================

Prompt ===> 2.1 Eliminando App COntainer
Prompt Eliminando pet_care_ac con sus datafiles en caso de existir 

set serveroutput on 
declare
  v_count number;
begin
  select count(*) into v_count from v$pdbs where name = 'PET_CARE_AC';
  if v_count > 0 then
    select count(*) into v_count 
    from v$pdbs
    where name = 'PET_CARE_AC' and open_mode <> 'MOUNTED';
    if v_count > 0 then  
      execute immediate 'alter pluggable database pet_care_ac close';
    end if;
    execute immediate 'drop pluggable database pet_care_ac including datafiles';
  end if;
end;
/

Prompt ===> 2.2 Crear el application container

create pluggable database pet_care_ac as application container
  admin user admin identified by admin
  file_name_convert = (
    '/opt/oracle/oradata/FREE/pdbseed',
    '/opt/oracle/oradata/FREE/pet_care_ac'
  );

Prompt 3. Abrir el application container
alter pluggable database pet_care_ac open read write;

Prompt 4. Conectarse al application container
alter session set container = pet_care_ac;

Prompt ============{ 5. Configuraicon de la App }=================

Prompt ===> 5.1 Iniciando la instalacion
alter pluggable database application pet_care_app begin install '1.0';

Prompt ===> { 5.2. Distribucion fisica de datafiles }

Prompt 5.2.1. distribucion fisica para =={ TABLAS }==
create tablespace pet_care_tb_ts 
  --datafile
  --  '/unam/diplo-bd/pet-care-disks/datafile-d01/pdbseed/pet_care_tb_ts_01.dbf' size 50m autoextend on next 5m maxsize unlimited,
  --  '/unam/diplo-bd/pet-care-disks/datafile-d02/pdbseed/pet_care_tb_ts_02.dbf' size 50m autoextend on next 5m maxsize unlimited,
  --  '/unam/diplo-bd/pet-care-disks/datafile-d03/pdbseed/pet_care_tb_ts_03.dbf' size 50m autoextend on next 5m maxsize unlimited
  extent management local autoallocate
  segment space management auto;

Prompt 5.2.2. distribucion fisica para =={ INDICES }==
create tablespace pet_care_ix_ts
  --datafile
  --  '/unam/diplo-bd/pet-care-disks/datafile-d01/pdbseed/pet_care_ix_ts_01.dbf' size 5m autoextend on next 10m maxsize unlimited,
  --  '/unam/diplo-bd/pet-care-disks/datafile-d02/pdbseed/pet_care_ix_ts_02.dbf' size 5m autoextend on next 10m maxsize unlimited,
  --  '/unam/diplo-bd/pet-care-disks/datafile-d03/pdbseed/pet_care_ix_ts_03.dbf' size 5m autoextend on next 10m maxsize unlimited
  extent management local autoallocate 
  segment space management auto;

Prompt 5.2.3. distribucion fisica para =={ almacenamiento de datos CLOB/BLOB }==
create tablespace pet_care_blob_ts
  --datafile
  --  '/unam/diplo-bd/pet-care-disks/datafile-d01/pdbseed/pet_care_blob_ts_01.dbf' size 100m autoextend on next 50m maxsize unlimited, 
  --  '/unam/diplo-bd/pet-care-disks/datafile-d02/pdbseed/pet_care_blob_ts_02.dbf' size 100m autoextend on next 50m maxsize unlimited, 
  --  '/unam/diplo-bd/pet-care-disks/datafile-d03/pdbseed/pet_care_blob_ts_03.dbf' size 100m autoextend on next 50m maxsize unlimited 
  extent management local autoallocate 
  segment space management auto;

Prompt ===> { 5.3. Creando y Configurando Uusarios }

Prompt ===> 5.3.1 Creando y Definiendo Usuario admin para pet_care_ac
Prompt            y definiendo sus tablespaces
create user pet_care_admin identified by pet_care_admin
  default tablespace pet_care_tb_ts
  quota unlimited on pet_care_tb_ts
  container = all;

Prompt ===> 5.3.2 Otorgandole privilegios al usuario admin
grant create session, create table, create procedure to pet_care_admin;

Prompt ===> 5.3.3 Otorgandole permisos sobre pet_care_ix_ts
alter user pet_care_admin quota unlimited on pet_care_ix_ts;

Prompt ===> 5.3.4 Otorgandole permisos sobre pet_care_blob_ts
alter user pet_care_admin quota unlimited on pet_care_blob_ts;

Prompt ===> { 5.4. Creando Tablas }

Prompt ===> 5.4.1 Verificamos donde estamos
show con_name

Prompt ===> 5.4.1 Verificamos quienes somos
show user;

Prompt ================================
Prompt Ejecutando e-11-creacion-tablas-fk.sql
Prompt ================================
Pause [ENTER] para continuar o Ctrl + C para cancelar
@e-11-creacion-tablas-fk.sql

Prompt ============{ 5. Terminando Configuraicon de la App }=================
connect sys/system2@pet_care_ac  as sysdba
alter pluggable database application pet_care_app end install;

Prompt =========={ 6. Iniciandpo Prueba de creacion de  }

Pause [ENTER] para continuar o Ctrl + C para cancelar
Prompt 6.1 Creando APP PDB pet_care_norte
create pluggable database pet_care_norte
  admin user pdb_admin identified by password1
  FILE_NAME_CONVERT =(
    '/opt/oracle/oradata/FREE/pdbseed', '/opt/oracle/oradata/FREE/pet_care_norte'
    );

Prompt 6.2 abriendo la app pdb pet_care_norte
alter pluggable database pet_care_norte open;

Prompt 6.3 entrando a la app pdb pet_care_norte
alter session set container = pet_care_norte;

Prompt 6.4 Sincronizando la app
Pause [ENTER] para continuar o Ctrl + C para cancelar
alter pluggable database application all sync;

spool off

/*
connect pdb_admin/password1@pet_care_norte

alter session set container = pet_care_ac;
alter pluggable database pet_care_norte close;
drop pluggable database pet_care_norte including datafiles;


Prompt 6. Creando las Applications PDBS
CREATE PLUGGABLE DATABASE pet_care_pdb_norte 
  ADMIN USER petcare_user IDENTIFIED BY user123 
  FILE_NAME_CONVERT = ('/opt/oracle/oradata/FREE/pet_care_ac/', 
                       '/opt/oracle/oradata/FREE/pet_care_ac/pet_care_pdb_norte/');

CREATE PLUGGABLE DATABASE pet_care_pdb_sur 
  ADMIN USER petcare_user IDENTIFIED BY user123 
  FILE_NAME_CONVERT = ('/opt/oracle/oradata/FREE/pet_care_ac/', 
                       '/opt/oracle/oradata/FREE/pet_care_ac/pet_care_pdb_sur/');

alter pluggable database  application all sync

set linesize window
col tablespace_name format a20
col file_name format a80
SELECT tablespace_name, file_name FROM dba_data_files;

*/