--@Autor: Martinez Martinez Francisco David
--@Fecha creación: 27/05/2025
--@Descripción: Script para cerrar y eliminar las PDBś 

Prompt 1. Conectandonos al CBD como sys 
connect sys/system2 as sysdba

Prompt 2. Conectarse al application container
--alter session set container = pet_care_ac;
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
      execute immediate 'alter session set container = pet_care_ac';
    end if;
  end if;
end;
/


Prompt 3. Eliminando las application pluggable databases 

Prompt 3.1. ============={ PET_CARE_SUR }==============
set serveroutput on 
declare
  v_count number;
begin
  select count(*) into v_count from v$pdbs where name = 'PET_CARE_SUR';
  if v_count > 0 then
    select count(*) into v_count 
    from v$pdbs
    where name = 'PET_CARE_SUR' and open_mode <> 'MOUNTED';
    if v_count > 0 then  
      execute immediate 'alter pluggable database pet_care_sur close';
    end if;
    execute immediate 'drop pluggable database pet_care_sur including datafiles';
  end if;
end;
/


Prompt 3.1. ============={ PET_CARE_NORTE }==============
set serveroutput on 
declare
  v_count number;
begin
  select count(*) into v_count from v$pdbs where name = 'PET_CARE_NORTE';
  if v_count > 0 then
    select count(*) into v_count 
    from v$pdbs
    where name = 'PET_CARE_NORTE' and open_mode <> 'MOUNTED';
    if v_count > 0 then  
      execute immediate 'alter pluggable database pet_care_norte close';
    end if;
    execute immediate 'drop pluggable database pet_care_norte including datafiles';
  end if;
end;
/