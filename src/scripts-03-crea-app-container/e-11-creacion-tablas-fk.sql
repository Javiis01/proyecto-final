--@Autor: Martinez Martinez Francisco David
--@Fecha creación: 27/05/2025
--@Descripción: Creacion de Tablas y Foreings Keys  


--------------------------------------Fi tablas ---------------------------

-- 
-- TABLE: CERTIFICADO 
--

ALTER TABLE CERTIFICADO ADD CONSTRAINT fk_inscripcioncurso_certificado 
    FOREIGN KEY (clvInscripcionCurso)
    REFERENCES INSCRIPCION_CURSO(clvInscripcionCurso)
;


-- 
-- TABLE: CLIENTE 
--

ALTER TABLE CLIENTE ADD CONSTRAINT fk_municipio_cliente 
    FOREIGN KEY (clvMunicipio)
    REFERENCES MUNICIPIO(clvMunicipio)
;


-- 
-- TABLE: CONSULTA_MEDICA 
--

ALTER TABLE CONSULTA_MEDICA ADD CONSTRAINT fk_diagnostico_consultamedico 
    FOREIGN KEY (clvDiagnostico)
    REFERENCES DIAGNOSTICO(clvDiagnostico)
;

ALTER TABLE CONSULTA_MEDICA ADD CONSTRAINT fk_mascota_consultamedica 
    FOREIGN KEY (clvMascota)
    REFERENCES MASCOTA(clvMascota)
;

ALTER TABLE CONSULTA_MEDICA ADD CONSTRAINT fk_veterinaria_consulta 
    FOREIGN KEY (clvVeterinario)
    REFERENCES VETERINARIO(clvVeterinario)
;


-- 
-- TABLE: EMPLEADO 
--

ALTER TABLE EMPLEADO ADD CONSTRAINT fk_empleado_supervisor 
    FOREIGN KEY (clvSupervisorEmp)
    REFERENCES EMPLEADO(clvEmpleado)
;

ALTER TABLE EMPLEADO ADD CONSTRAINT fk_veterinaria_empleado 
    FOREIGN KEY (clvVeterinaria)
    REFERENCES VETERINARIA(clvVeterinaria)
;


-- 
-- TABLE: ESTILISTA 
--

ALTER TABLE ESTILISTA ADD CONSTRAINT RefEMPLEADO56 
    FOREIGN KEY (clvEstilista)
    REFERENCES EMPLEADO(clvEmpleado)
;


-- 
-- TABLE: FOTO_MASCOTA 
--

ALTER TABLE FOTO_MASCOTA ADD CONSTRAINT fk_mascota_foto_mascota 
    FOREIGN KEY (clvMascota)
    REFERENCES MASCOTA(clvMascota)
;


-- 
-- TABLE: HISTORICO_ESTATUS_PRODUCTOS 
--

ALTER TABLE HISTORICO_ESTATUS_PRODUCTOS ADD CONSTRAINT fk_estatusproducto_historicoestatusprod 
    FOREIGN KEY (clvEstatusProdInventario)
    REFERENCES ESTATUS_PROD_INVENTARIO(clvEstatusProdInventario)
;

ALTER TABLE HISTORICO_ESTATUS_PRODUCTOS ADD CONSTRAINT fk_inventarioveterinaria_historicoestatusprod 
    FOREIGN KEY (clvInventarioVet)
    REFERENCES INVENTARIO_VETERINARIA(clvInventarioVet)
;


-- 
-- TABLE: HISTORICO_PRECIO 
--

ALTER TABLE HISTORICO_PRECIO ADD CONSTRAINT fk_producto_historicoprecio 
    FOREIGN KEY (SKU)
    REFERENCES PRODUCTO(SKU)
;


-- 
-- TABLE: INSCRIPCION_CURSO 
--

ALTER TABLE INSCRIPCION_CURSO ADD CONSTRAINT fk_curso_inscripcioncurso 
    FOREIGN KEY (clvCurso)
    REFERENCES CURSO(clvCurso)
;

ALTER TABLE INSCRIPCION_CURSO ADD CONSTRAINT fk_estilista_inscripcioncurso 
    FOREIGN KEY (clvEstilista)
    REFERENCES ESTILISTA(clvEstilista)
;


-- 
-- TABLE: INVENTARIO_VETERINARIA 
--

ALTER TABLE INVENTARIO_VETERINARIA ADD CONSTRAINT fk_estatusprod_inventarioveterinaria 
    FOREIGN KEY (clvEstatusProdInventario)
    REFERENCES ESTATUS_PROD_INVENTARIO(clvEstatusProdInventario)
;

ALTER TABLE INVENTARIO_VETERINARIA ADD CONSTRAINT fk_producto_inventarioveterinaria 
    FOREIGN KEY (SKU)
    REFERENCES PRODUCTO(SKU)
;

ALTER TABLE INVENTARIO_VETERINARIA ADD CONSTRAINT fk_veterinaria_inventarioveterinaria 
    FOREIGN KEY (clvVeterinaria)
    REFERENCES VETERINARIA(clvVeterinaria)
;


-- 
-- TABLE: MASCOTA 
--

ALTER TABLE MASCOTA ADD CONSTRAINT fk_cliente_mascota 
    FOREIGN KEY (clvCliente)
    REFERENCES CLIENTE(clvCliente)
;


-- 
-- TABLE: MASCOTA_PASEO 
--

ALTER TABLE MASCOTA_PASEO ADD CONSTRAINT fk_mascota_mascpaseo 
    FOREIGN KEY (clvMascota)
    REFERENCES MASCOTA(clvMascota)
;

ALTER TABLE MASCOTA_PASEO ADD CONSTRAINT fk_paseo_mascpaseo 
    FOREIGN KEY (clvPaseo)
    REFERENCES PASEO(clvPaseo)
;


-- 
-- TABLE: MONITOREO_PASEO 
--

ALTER TABLE MONITOREO_PASEO ADD CONSTRAINT fk_paseo_monitoreopaseo 
    FOREIGN KEY (clvPaseo)
    REFERENCES PASEO(clvPaseo)
;


-- 
-- TABLE: MUNICIPIO 
--

ALTER TABLE MUNICIPIO ADD CONSTRAINT fk_estado_municipios 
    FOREIGN KEY (clvEstado)
    REFERENCES ESTADO(clvEstado)
;


-- 
-- TABLE: ORDEN_COMPRA 
--

ALTER TABLE ORDEN_COMPRA ADD CONSTRAINT fk_cliente_ordencompra 
    FOREIGN KEY (clvClienteCompra)
    REFERENCES CLIENTE(clvCliente)
;

ALTER TABLE ORDEN_COMPRA ADD CONSTRAINT fk_vendedor_ordencompra 
    FOREIGN KEY (clvVendedorCompra)
    REFERENCES VENDEDOR(clvVendedor)
;


-- 
-- TABLE: ORDEN_PRODUCTO 
--

ALTER TABLE ORDEN_PRODUCTO ADD CONSTRAINT fk_ordencompra_ordenproducto 
    FOREIGN KEY (clvOrdenCompra)
    REFERENCES ORDEN_COMPRA(clvOrdenCompra)
;

ALTER TABLE ORDEN_PRODUCTO ADD CONSTRAINT fk_producto_ordenproducto 
    FOREIGN KEY (SKU)
    REFERENCES PRODUCTO(SKU)
;


-- 
-- TABLE: PASEO 
--

ALTER TABLE PASEO ADD CONSTRAINT fk_vendedor_paseo 
    FOREIGN KEY (clvVendedor)
    REFERENCES VENDEDOR(clvVendedor)
;


-- 
-- TABLE: PRODUCTO 
--

ALTER TABLE PRODUCTO ADD CONSTRAINT fk_categoria_producto 
    FOREIGN KEY (clvCategoria)
    REFERENCES CATEGORIA(clvCategoria)
;


-- 
-- TABLE: SERVICIO_ESTETICA 
--

ALTER TABLE SERVICIO_ESTETICA ADD CONSTRAINT fk_estilista_servicioestetica 
    FOREIGN KEY (clvEstilista)
    REFERENCES ESTILISTA(clvEstilista)
;

ALTER TABLE SERVICIO_ESTETICA ADD CONSTRAINT fk_mascota_servicioestetica 
    FOREIGN KEY (clvMascota)
    REFERENCES MASCOTA(clvMascota)
;


-- 
-- TABLE: TELEFONO_CLIENTE 
--

ALTER TABLE TELEFONO_CLIENTE ADD CONSTRAINT fk_cliente_telefono 
    FOREIGN KEY (clvCliente)
    REFERENCES CLIENTE(clvCliente)
;


-- 
-- TABLE: VENDEDOR 
--

ALTER TABLE VENDEDOR ADD CONSTRAINT RefEMPLEADO58 
    FOREIGN KEY (clvVendedor)
    REFERENCES EMPLEADO(clvEmpleado)
;


-- 
-- TABLE: VETERINARIA 
--

ALTER TABLE VETERINARIA ADD CONSTRAINT fk_vendedor_veterinaria 
    FOREIGN KEY (clvGerente)
    REFERENCES VENDEDOR(clvVendedor)
;


-- 
-- TABLE: VETERINARIO 
--

ALTER TABLE VETERINARIO ADD CONSTRAINT RefEMPLEADO57 
    FOREIGN KEY (clvVeterinario)
    REFERENCES EMPLEADO(clvEmpleado)
;


