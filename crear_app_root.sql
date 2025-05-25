-- 1. spool del script
spool logs/crear_app_root.txt

-- 2. Conectando como sysdba en CDB
connect sys/system2 as sysdba

-- 3.1 Verificar y eliminar el contenedor anterior si existe
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

-- 3.2 Crear el application container
create pluggable database pet_care_ac as application container
  admin user admin identified by admin
  file_name_convert = (
    '/opt/oracle/oradata/FREE/pdbseed',
    '/opt/oracle/oradata/FREE/pet_care_ac'
  );

-- 4. Abrir el application container
alter pluggable database pet_care_ac open read write;

-- 5. Conectarse al application container
alter session set container = pet_care_ac;

alter pluggable database application pet_care_app begin install '1.0';

-- crearmkdir -p /opt/oracle/oradata/FREE/pet_care_ac_tbs crear desde oracle

create tablespace pet_care_ix_ts 
  datafile '/opt/oracle/oradata/FREE/pet_care_ac_tbs/pet_care_ix_ts_01.dbf'
  size 5m 
  AUTOEXTEND ON 
  NEXT 10M 
  MAXSIZE UNLIMITED 
  extent management local autoallocate 
  segment space management auto;

--HAy que darle permisos a las carpetas donde iran lso datafile desde ul usuario root de host

create tablespace pet_care_tbs 
  datafile
    '/unam/diplo-bd/pet-care-disks/datafile-d01/pet_care_tbs_01.dbf' size 50m autoextend on next 5m maxsize unlimited,
    '/unam/diplo-bd/pet-care-disks/datafile-d02/pet_care_tbs_02.dbf' size 50m autoextend on next 5m maxsize unlimited,
    '/unam/diplo-bd/pet-care-disks/datafile-d03/pet_care_tbs_03.dbf' size 50m autoextend on next 5m maxsize unlimited
  extent management local autoallocate
  segment space management auto;

  create tablespace pet_care_blob_ts
datafile
'/unam/diplo-bd/pet-care-disks/datafile-d01/pet_care_blob_ts_01.dbf' size 100m autoextend on next 50m maxsize unlimited, 
'/unam/diplo-bd/pet-care-disks/datafile-d01/pet_care_blob_ts_02.dbf' size 100m autoextend on next 50m maxsize unlimited, 
'/unam/diplo-bd/pet-care-disks/datafile-d01/pet_care_blob_ts_03.dbf' size 100m autoextend on next 50m maxsize unlimited 
extent management local autoallocate 
segment space management auto;


create user pet_care_admin identified by pet_care_admin
  default tablespace pet_care_tbs
  quota unlimited on pet_care_tbs
  container = all;

grant create session, create table, create procedure to pet_care_admin;
ALTER USER pet_care_admin QUOTA UNLIMITED ON pet_care_ix_ts;
ALTER USER pet_care_admin QUOTA UNLIMITED ON pet_care_blob_ts;

-- Conectarse como el usuario común de la app
 connect pet_care_admin/pet_care_admin@pet_care_ac 

-- Crear tablas con sus respectivos tablespaces
@petCare.sql

-- Volver a SYS y cerrar el upgrade
connect sys/system2@pet_care_ac  as sysdba
alter pluggable database application pet_care_app end install;

alter pluggable database  application pet_care_app begin upgrade '1.0' to '1.1';

 connect pet_care_admin/pet_care_admin@pet_care_ac 

@petcare_inserts_catalogos

connect sys/system2@pet_care_ac  as sysdba
alter pluggable database  application  pet_care_app end upgrade;


/*
create pluggable database pet_care_sur
  admin user admin identified by admin
  file_name_convert=(
    '/opt/oracle/oradata/FREE/pdbseed',
    '/opt/oracle/oradata/FREE/pet_care_ac/pet_care_sur'
  );

  alter pluggable database pet_care_sur open read write;


alter session set container=pet_care_sur;


Prompt TBS de la pdb sur

create tablespace pet_care_ix_ts 
  datafile '/opt/oracle/oradata/FREE/pet_care_ac/pet_care_sur/pet_care_ix_ts_01.dbf'
  size 5m 
  AUTOEXTEND ON 
  NEXT 10M 
  MAXSIZE UNLIMITED 
  extent management local autoallocate 
  segment space management auto;


create tablespace pet_care_tbs 
  datafile
    '/unam/diplo-bd/pet-care-disks/datafile-d01/pet_care_sur_01.dbf' size 50m autoextend on next 5m maxsize unlimited,
    '/unam/diplo-bd/pet-care-disks/datafile-d02/pet_care_sur_02.dbf' size 50m autoextend on next 5m maxsize unlimited,
    '/unam/diplo-bd/pet-care-disks/datafile-d03/pet_care_sur_03.dbf' size 50m autoextend on next 5m maxsize unlimited
  extent management local autoallocate
  segment space management auto;

  create tablespace pet_care_blob_ts
datafile
'/unam/diplo-bd/pet-care-disks/datafile-d01/pet_care_sur_blob_ts_01.dbf' size 100m autoextend on next 50m maxsize unlimited, 
'/unam/diplo-bd/pet-care-disks/datafile-d01/pet_care_sur_blob_ts_02.dbf' size 100m autoextend on next 50m maxsize unlimited, 
'/unam/diplo-bd/pet-care-disks/datafile-d01/pet_care_sur_blob_ts_03.dbf' size 100m autoextend on next 50m maxsize unlimited 
extent management local autoallocate 
segment space management auto;



Borrar pdb
ALTER PLUGGABLE DATABASE pet_care_sur CLOSE IMMEDIATE;
DROP PLUGGABLE DATABASE pet_care_sur INCLUDING DATAFILES;

Borrar pdb
ALTER PLUGGABLE DATABASE pet_care_ac CLOSE IMMEDIATE;
DROP PLUGGABLE DATABASE pet_care_ac INCLUDING DATAFILES;

*/
alter pluggable database  application all sync;