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

--alter system set db_create_file_dest = '/opt/oracle/oradata' scope = memory;

create tablespace pet_care_ix_ts 
  datafile '/opt/oracle/oradata/FREE/pet_care_ac/pet_care_ix_ts_01.dbf'
  size 5m autoextend on next 1m 
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


-- Conectarse como el usuario común de la app
 connect pet_care_admin/pet_care_admin@pet_care_ac 

-- Crear tablas con sus respectivos tablespaces
@petCare.sql

-- Volver a SYS y cerrar el upgrade
connect sys/system2 as sysdba
alter session set container=pet_care_ac;
alter pluggable database application pet_care_app end install;



/*

















create pluggable database petcare_ventas_sur
  admin user admin identified by admin
  file_name_convert=(
    '/opt/oracle/oradata/FREE/pdbseed',
    '/opt/oracle/oradata/FREE/pet_care_ac/petcare_ventas_sur'
  );
  alter pluggable database petcare_ventas_sur open read write;

-- 6. Iniciar instalación de la aplicación
alter pluggable database application pet_care_app begin install '1.0';

-- 6.1 Crear tablespace y usuario común
alter system set db_create_file_dest = '/opt/oracle/oradata' scope = memory;

create tablespace pet_care_app_ts
  datafile size 100m autoextend on next 10m;

create user pet_care_user identified by pet_care_user
  default tablespace pet_care_app_ts
  quota unlimited on pet_care_app_ts
  container=all;

grant create session, create table, create procedure to pet_care_user;

-- 6.2 Conectarse como pet_care_user
connect pet_care_user/pet_care_user@JCMDIPLO5_PETCARE

-- 6.3 Crear objetos como usuario común (ejemplo)
@petCare.sql

-- Si aquí tienes tu script de creación del modelo PetCare, lo puedes ejecutar directamente

-- 7. Terminar instalación desde SYS
connect sys/system5 as sysdba
alter session set container = pet_care_ac;
alter pluggable database application pet_care_app end install;

connect pet_care_user/pet_care_user@JCMDIPLO5_PETCARE
alter session set container=petcare_ventas_sur;
alter pluggable database  application all sync;

insert into ESTADO values(1,'CDMX');

select * from ESTADO;

connect sys/system5 as sysdba

alter session set container = pet_care_ac;
-- ==============================
-- 8. Desinstalación de aplicación
-- ==============================

alter pluggable database petcare_ventas_sur close;
drop pluggable database petcare_ventas_sur including datafiles;

-- Iniciar uninstall
alter pluggable database application pet_care_app begin uninstall;

-- Conectarse como pet_care_user para eliminar objetos comunes
connect pet_care_user/pet_care_user@JCMDIPLO5_PETCARE

disconnect

-- Volver a SYS y eliminar usuario/tablespace
connect sys/system5 as sysdba
alter session set container = pet_care_ac;

drop user pet_care_user cascade;
drop tablespace pet_care_app_ts including contents and datafiles;

-- Terminar uninstall de la aplicación
alter pluggable database application pet_care_app end uninstall;

-- 9. Eliminar el application container
alter session set container = cdb$root;
alter pluggable database pet_care_ac close;
drop pluggable database pet_care_ac including datafiles;

-- 10. Finalizar spool
spool off
disconnect
*/