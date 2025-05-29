--@Autor: Martinez Martinez Francisco David
--@Fecha creación: 27/05/2025
--@Descripción: Creación del App Container y Llamado a creacion de tablas e inserts

Prompt ===> { &paso 3. Distribucion fisica de datafiles }

Prompt &paso 3.1. distribucion fisica para =={ TABLAS }==
create tablespace pet_care_tb_ts 
  datafile
    '/unam/diplo-bd/pet-care-disks/datafile-d01/&directorio_pdb/pet_care_tb_ts_01.dbf' size 50m autoextend on next 5m maxsize unlimited,
    '/unam/diplo-bd/pet-care-disks/datafile-d02/&directorio_pdb/pet_care_tb_ts_02.dbf' size 50m autoextend on next 5m maxsize unlimited,
    '/unam/diplo-bd/pet-care-disks/datafile-d03/&directorio_pdb/pet_care_tb_ts_03.dbf' size 50m autoextend on next 5m maxsize unlimited
  extent management local autoallocate
  segment space management auto;

Prompt &paso 3.2. distribucion fisica para =={ INDICES }==
create tablespace pet_care_ix_ts
  datafile
    '/unam/diplo-bd/pet-care-disks/datafile-d01/&directorio_pdb/pet_care_ix_ts_01.dbf' size 5m autoextend on next 10m maxsize unlimited,
    '/unam/diplo-bd/pet-care-disks/datafile-d02/&directorio_pdb/pet_care_ix_ts_02.dbf' size 5m autoextend on next 10m maxsize unlimited,
    '/unam/diplo-bd/pet-care-disks/datafile-d03/&directorio_pdb/pet_care_ix_ts_03.dbf' size 5m autoextend on next 10m maxsize unlimited
  extent management local autoallocate 
  segment space management auto;

Prompt &paso 3.3. distribucion fisica para =={ almacenamiento de datos CLOB/BLOB }==
create tablespace pet_care_blob_ts
  datafile
    '/unam/diplo-bd/pet-care-disks/datafile-d01/&directorio_pdb/pet_care_blob_ts_01.dbf' size 100m autoextend on next 50m maxsize unlimited, 
    '/unam/diplo-bd/pet-care-disks/datafile-d02/&directorio_pdb/pet_care_blob_ts_02.dbf' size 100m autoextend on next 50m maxsize unlimited, 
    '/unam/diplo-bd/pet-care-disks/datafile-d03/&directorio_pdb/pet_care_blob_ts_03.dbf' size 100m autoextend on next 50m maxsize unlimited 
  extent management local autoallocate 
  segment space management auto;

Prompt ===> { &paso 4. Creando y Configurando Uusarios }

Prompt ===> &paso 4.1 Creando y Definiendo Usuario admin para pet_care_ac
Prompt            y definiendo sus tablespaces
create user pet_care_admin identified by pet_care_admin
  default tablespace pet_care_tb_ts
  quota unlimited on pet_care_tb_ts
  container = all;

Prompt ===> &paso 4.2 Otorgandole privilegios al usuario admin
grant create session, create table, create procedure to pet_care_admin;

Prompt ===> &paso 4.3 Otorgandole permisos sobre pet_care_ix_ts
alter user pet_care_admin quota unlimited on pet_care_ix_ts;

Prompt ===> &paso 4.4 Otorgandole permisos sobre pet_care_blob_ts
alter user pet_care_admin quota unlimited on pet_care_blob_ts;
