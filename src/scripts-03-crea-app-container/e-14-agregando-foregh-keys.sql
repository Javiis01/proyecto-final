-- @Autor: Martinez Martinez Francisco David
-- @Fecha: 30/05/2025
-- @Descripción: Script interactivo para aplicar upgrade o instalación de pet_care_app

Prompt 1. Conectandonos al CBD como sys 
connect sys/system2 as sysdba

Prompt 2. Conectarse al application container
alter session set container = pet_care_ac;


-- Paso 1: Verificar existencia y versión de pet_care_app
PROMPT ================================
PROMPT Verificando existencia de pet_care_app...
PROMPT ================================

SET LINESIZE WINDOW
COLUMN app_name FORMAT A20
COLUMN app_version FORMAT A10
COLUMN app_status FORMAT A20

SELECT app_name, app_version, app_status
FROM   dba_applications
WHERE  app_name = 'PET_CARE_APP';

-- Paso 2: Obtener versiones de forma interactiva
ACCEPT v_actual CHAR PROMPT 'Ingrese la versión ACTUAL de pet_care_app (ej. 1.0) o presione ENTER para cancelar: '

-- Cancelar si no se ingresó versión actual
set serveroutput on
BEGIN
  IF '&&v_actual' IS NULL THEN
    DBMS_OUTPUT.PUT_LINE('Ejecución cancelada. No se proporcionó versión actual.');
    RAISE_APPLICATION_ERROR(-20001, 'Cancelado por el usuario');
  END IF;
END;
/

ACCEPT v_final CHAR PROMPT 'Ingrese la versión FINAL (upgrade) que desea aplicar (ej. 1.1): '

-- Paso 3: Iniciar instalación o upgrade
--SET FEEDBACK OFF
set serveroutput on
BEGIN
  IF '&&v_actual' = '0.0' THEN
    DBMS_OUTPUT.PUT_LINE('Iniciando instalación de pet_care_app versión &&v_final...');
    EXECUTE IMMEDIATE 'ALTER PLUGGABLE DATABASE APPLICATION pet_care_app BEGIN INSTALL ''' || '&&v_final' || '''';
  ELSE
    DBMS_OUTPUT.PUT_LINE('Realizando upgrade de pet_care_app de versión &&v_actual a &&v_final...');
    EXECUTE IMMEDIATE 'ALTER PLUGGABLE DATABASE APPLICATION pet_care_app BEGIN UPGRADE ''' || '&&v_actual' || ''' TO ''' || '&&v_final' || '''';
  END IF;
END;
/

-- Paso 4: Ejecutar script de claves foráneas
PROMPT ================================
PROMPT Ejecutando e-15-foreigh-keys.sql
PROMPT ================================
PAUSE Presione [ENTER] para continuar o Ctrl+C para cancelar
@e-15-foreigh-keys.sql

-- Paso 5: Finalizar instalación o upgrade
set serveroutput on
BEGIN
  IF '&&v_actual' = '0.0' THEN
    EXECUTE IMMEDIATE 'ALTER PLUGGABLE DATABASE APPLICATION pet_care_app END INSTALL';
    DBMS_OUTPUT.PUT_LINE('Instalación finalizada correctamente.');
  ELSE
    EXECUTE IMMEDIATE 'ALTER PLUGGABLE DATABASE APPLICATION pet_care_app END UPGRADE TO ''' || '&&v_final' || '''';
    DBMS_OUTPUT.PUT_LINE('Upgrade finalizado correctamente.');
  END IF;
END;
/

-- Paso 6: Conectarse a PDBs y sincronizar
PROMPT ================================
PROMPT Sincronizando pet_care_norte...
PROMPT ================================
ALTER SESSION SET CONTAINER = pet_care_norte;
ALTER PLUGGABLE DATABASE APPLICATION ALL SYNC;

PROMPT ================================
PROMPT Sincronizando pet_care_sur...
PROMPT ================================
ALTER SESSION SET CONTAINER = pet_care_sur;
ALTER PLUGGABLE DATABASE APPLICATION ALL SYNC;

PROMPT ===========================================
PROMPT    Proceso de instalación/upgrade finalizado
PROMPT ===========================================

