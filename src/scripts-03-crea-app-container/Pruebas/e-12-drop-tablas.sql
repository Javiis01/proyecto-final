--@Autor: Martinez Martinez Francisco David
--@Fecha creación: 27/05/2025
--@Descripción: Creación del App Container y Llamado a creacion de tablas e inserts

Prompt ===> { &paso 2.1 Limpieza de usuario y tablas }
/*BEGIN
    FOR u IN (
        SELECT username FROM dba_users
        WHERE username = 'PET_CARE_ADMIN'
    ) LOOP
        EXECUTE IMMEDIATE 'DROP USER ' || u.username || ' CASCADE';
    END LOOP;
END;
/*/

/*Prompt ===> { &paso 2.2. LImpieza de tablespaces }
BEGIN
    FOR ts IN (
        SELECT tablespace_name FROM dba_tablespaces
        WHERE tablespace_name IN (
            'PET_CARE_TB_TS',
            'PET_CARE_IX_TS',
            'PET_CARE_BLOB_TS'
        )
    ) LOOP
        EXECUTE IMMEDIATE 'DROP TABLESPACE ' || ts.tablespace_name || ' INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS';
    END LOOP;
END;
/*/
ALTER SESSION SET CONTAINER = PET_CARE_AC;
DROP USER IF EXISTS PET_CARE_ADMIN CASCADE;
DROP TABLESPACE IF EXISTS PET_CARE_TB_TS INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
DROP TABLESPACE IF EXISTS PET_CARE_IX_TS INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
DROP TABLESPACE IF EXISTS PET_CARE_BLOB_TS INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;

Pause [ENTER] para continuar o Ctrl + C para cancelar
