--@Autor: Martinez Martinez Francisco David
--@Fecha creación: 28/05/2025
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

mkdir -p /unam/diplo-bd/pet-care-disks/datafile-d01/pet_care_sur
mkdir -p /unam/diplo-bd/pet-care-disks/datafile-d02/pet_care_sur
mkdir -p /unam/diplo-bd/pet-care-disks/datafile-d03/pet_care_sur
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

