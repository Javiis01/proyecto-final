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

set linesize window

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

/*
Primera instalacion para el NORTE
*/
define paso = '5.'
define version = '1.0'
define directorio_pdb = 'pet_care_norte'
Prompt ============{ &paso Configuraicon Version &version de la App }=================
Prompt ====> Para &directorio_pdb

Prompt ===> &paso 1. Iniciando la instalacion
alter pluggable database application pet_care_app_01 begin install '&version';

Prompt ===> { &paso 2. Limpienado la app }
Pause [ENTER] para continuar o Ctrl + C para cancelar
@e-12-drop-tablas.sql

Prompt ===> { &paso 3. tablespace}
Pause [ENTER] para continuar o Ctrl + C para cancelar
@e-13-tablespaces-user.sql

Prompt ===> { &paso 5. Creacion de tablas}

Prompt ===> &paso 5.1 Conectandonos con el usuario admin de pec_care_ac
connect pet_care_admin/pet_care_admin@pet_care_ac

Prompt ================================
Prompt Ejecutando e-14-creacion-tablas-fk.sql
Prompt ================================
Pause [ENTER] para continuar o Ctrl + C para cancelar
@e-14-creacion-tablas-fk.sql


Pause [ENTER] para continuar o Ctrl + C para cancelar
Prompt ============{ &paso Terminando Configuraicon de la App }=================
connect sys/system2@pet_care_ac  as sysdba
alter pluggable database application pet_care_app end install;

/*
Segunda instalacion para el pdbseed
*/
define paso = '6.'
define version = '2.0'
define directorio_pdb = 'pdbseed'
Prompt ============{ &paso Configuraicon Version &version de la App }=================
Prompt ====> Para &directorio_pdb

Prompt ===> &paso 1. Iniciando la instalacion
alter pluggable database application pet_care_app_02 begin install '&version';

Prompt ===> { &paso 2. Limpienado la app }
Pause [ENTER] para continuar o Ctrl + C para cancelar
@e-12-drop-tablas.sql

Prompt ===> { &paso 3. tablespace}
Pause [ENTER] para continuar o Ctrl + C para cancelar
@e-13-tablespaces-user.sql

Prompt ===> { &paso 5. Creacion de tablas}

Prompt ===> &paso 5.1 Conectandonos con el usuario admin de pec_care_ac
connect pet_care_admin/pet_care_admin@pet_care_ac

Prompt ================================
Prompt Ejecutando e-14-creacion-tablas-fk.sql
Prompt ================================
Pause [ENTER] para continuar o Ctrl + C para cancelar
@e-14-creacion-tablas-fk.sql


Pause [ENTER] para continuar o Ctrl + C para cancelar
Prompt ============{ &paso Terminando Configuraicon de la App }=================
connect sys/system2@pet_care_ac  as sysdba
alter pluggable database application pet_care_app end install;


Prompt =========={ 7. Iniciandpo Prueba de creacion de  }

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
alter pluggable database application all sync to version '1.0';

spool off

