SET SERVEROUTPUT ON;
BEGIN
INSERT INTO PET_CARE_ADMIN.ESTADO (clvEstado, nombreEstado) VALUES (1, 'Nuevo Leon');
INSERT INTO PET_CARE_ADMIN.ESTADO (clvEstado, nombreEstado) VALUES (2, 'CDMX');
INSERT INTO PET_CARE_ADMIN.ESTADO (clvEstado, nombreEstado) VALUES (3, 'Quintana Roo');
INSERT INTO PET_CARE_ADMIN.ESTADO (clvEstado, nombreEstado) VALUES (4, 'Tabasco');
INSERT INTO PET_CARE_ADMIN.ESTADO (clvEstado, nombreEstado) VALUES (5, 'Tamaulipas');

INSERT INTO PET_CARE_ADMIN.MUNICIPIO (clvMunicipio, nombreMunicipio, clvEstado) VALUES (1, 'Vieja República Demo', 1);
INSERT INTO PET_CARE_ADMIN.MUNICIPIO (clvMunicipio, nombreMunicipio, clvEstado) VALUES (2, 'Nueva Togo', 4);
INSERT INTO PET_CARE_ADMIN.MUNICIPIO (clvMunicipio, nombreMunicipio, clvEstado) VALUES (3, 'Vieja Guinea', 5);
INSERT INTO PET_CARE_ADMIN.MUNICIPIO (clvMunicipio, nombreMunicipio, clvEstado) VALUES (4, 'San Emilia los altos', 3);
INSERT INTO PET_CARE_ADMIN.MUNICIPIO (clvMunicipio, nombreMunicipio, clvEstado) VALUES (5, 'San Sara los altos', 1);
INSERT INTO PET_CARE_ADMIN.MUNICIPIO (clvMunicipio, nombreMunicipio, clvEstado) VALUES (6, 'San Violeta de la Mo', 3);
INSERT INTO PET_CARE_ADMIN.MUNICIPIO (clvMunicipio, nombreMunicipio, clvEstado) VALUES (7, 'San Rufino los altos', 1);
INSERT INTO PET_CARE_ADMIN.MUNICIPIO (clvMunicipio, nombreMunicipio, clvEstado) VALUES (8, 'San Augusto los bajo', 3);
INSERT INTO PET_CARE_ADMIN.MUNICIPIO (clvMunicipio, nombreMunicipio, clvEstado) VALUES (9, 'San Gilberto los alt', 2);
INSERT INTO PET_CARE_ADMIN.MUNICIPIO (clvMunicipio, nombreMunicipio, clvEstado) VALUES (10, 'Nueva Sri Lanka', 1);
COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE('En línea: ' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
END;
/