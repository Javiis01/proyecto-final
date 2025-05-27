#@Autor: <Nombre del autor o autores> 
#@Fecha creación: <Fecha de creación> 
#@Descripción: Creacion del contenedor para el Proyecto FInal

#/bin/bash

# ==========={ NOTA }==============
# Cambiar las inciales de DSPLAY ol-jcm:1.0 bash 

echo "Creando un nuevo contenedor"

docker run -i -t \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v /unam:/unam \
--name pet-care \
--hostname pet-care.fi.unam \
--expose 1521 \
--expose 5500 \
--shm-size=2gb \
-e DISPLAY=$DISPLAY ol-jcm:1.0 bash