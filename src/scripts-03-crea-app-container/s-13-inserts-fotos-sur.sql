

--CREATE OR REPLACE DIRECTORY FOTOS_PERROS_DIR AS '/unam/diplo-bd/fotosPerros';
CREATE OR REPLACE DIRECTORY FOTOS_PERROS_DIR AS '/unam/diplo-bd/pet-care-fotos';

DECLARE
  v_bfile  BFILE := BFILENAME('FOTOS_PERROS_DIR', 'perro1.png');
  v_blob   BLOB;
BEGIN
  -- Abre el archivo físico
  DBMS_LOB.OPEN(v_bfile, DBMS_LOB.LOB_READONLY);

  -- Inicializa un BLOB temporal
  DBMS_LOB.CREATETEMPORARY(v_blob, TRUE);

  -- Carga el contenido del archivo al BLOB
  DBMS_LOB.LOADFROMFILE(v_blob, v_bfile, DBMS_LOB.getlength(v_bfile));

  -- Actualiza los primeros 10 registros de la tabla con la imagen
  FOR r IN (SELECT clvFotoMascota FROM (
               SELECT clvFotoMascota FROM PET_CARE_ADMIN.FOTO_MASCOTA ORDER BY clvFotoMascota FETCH FIRST 10 ROWS ONLY
             ))
  LOOP
    UPDATE PET_CARE_ADMIN.FOTO_MASCOTA
    SET fotoMascota = v_blob
    WHERE clvFotoMascota = r.clvFotoMascota;
  END LOOP;

  -- Libera recursos
  DBMS_LOB.FREETEMPORARY(v_blob);
  DBMS_LOB.CLOSE(v_bfile);
END;
/