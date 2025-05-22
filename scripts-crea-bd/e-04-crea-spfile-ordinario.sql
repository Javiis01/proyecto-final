--@Autor:          Javier Carranza Mendoza
--@Fecha creación:  19/12/2024
--@Descripción: Creación de un SPFILE

prompt 0. Generando spool
spool jcm-e-04-crea-spfile-ordinario-spool.txt

Prompt 1. Conectando como sys empleando archivo de passwords 
connect sys/Hola1234* as sysdba

Prompt  2. Creando el SPFILE a partir del PFILE
create spfile from pfile;


Prompt 3. verificando su existencia.
!ls -l ${ORACLE_HOME}/dbs/spfile${ORACLE_SID}.ora

Prompt Listo!
spool off 

/*
Conclusiones
    ¿El ejercicio aportó y/o mejoró la comprensión del concepto ?
    Ayudo a entender que se puede generar un pfile atravez de un spfile que podemos hacer manualmente

    Problemas identificados durante su elaboración así como la forma en la que se solucionaron
    Ninguno

    Comentarios, sugerencias.
    ALomejor agregar algun parametro extra para este ejercicio para despues mostrarlo
*/
exit