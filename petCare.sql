--
-- ER/Studio 8.0 SQL Code Generation
-- Company :      FI-UNAM
-- Project :      Modelo Relacional_Corregido_v01.DM1
-- Author :       JossBass
--
-- Date Created : Saturday, May 03, 2025 19:23:18
-- Target DBMS : Oracle 11g
--

-- 
-- TABLE: CATEGORIA 
--


CREATE TABLE CATEGORIA(
    clvCategoria            NUMBER(38, 0)    NOT NULL,
    nombreCategoria         VARCHAR2(20)     NOT NULL,
    descripcionCategoria    VARCHAR2(30)     NOT NULL,
    CONSTRAINT pk_categoria PRIMARY KEY (clvCategoria)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;


-- 
-- TABLE: CERTIFICADO 
--

CREATE TABLE CERTIFICADO(
    clvCursoAprobado            NUMBER(38, 0)    NOT NULL,
    clvInscripcionCurso         NUMBER(38, 0)    NOT NULL,
    nombreCertificado           VARCHAR2(30)     NOT NULL,
    certificadoPrueba           CHAR(10)         NOT NULL,
    fechaAprobadoCertificado    DATE             NOT NULL,
    CONSTRAINT pk_certificado PRIMARY KEY (clvCursoAprobado)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: CLIENTE 
--

CREATE TABLE CLIENTE(
    clvCliente             NUMBER(38, 0)    NOT NULL,
    clvMunicipio           NUMBER(38, 0)    NOT NULL,
    nombreClie             VARCHAR2(20)     NOT NULL,
    apPaternoClie          VARCHAR2(20)     NOT NULL,
    apMaternoClie          VARCHAR2(20)     NOT NULL,
    fechaNacimientoClie    DATE             NOT NULL,
    correoClie             VARCHAR2(30)     NOT NULL,
    CONSTRAINT pk_cliente PRIMARY KEY (clvCliente)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: CONSULTA_MEDICA 
--

CREATE TABLE CONSULTA_MEDICA(
    clvConsultaMedica            NUMBER(38, 0)    NOT NULL,
    clvVeterinario               NUMBER(38, 0)    NOT NULL,
    clvDiagnostico               NUMBER(38, 0)    NOT NULL,
    descripcionEstadoConsulta    VARCHAR2(50)     NOT NULL,
    costoConsulta                NUMBER(10, 2)    NOT NULL,
    fechaConsulta                DATE             NOT NULL,
    clvMascota                   NUMBER(38, 0)    NOT NULL,
    CONSTRAINT pk_consulta_medica PRIMARY KEY (clvConsultaMedica)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: CURSO 
--

CREATE TABLE CURSO(
    clvCurso              NUMBER(38, 0)    NOT NULL,
    codigoInternoCurso    NUMBER(38, 0)    NOT NULL,
    UUID                  VARCHAR2(36)     NOT NULL,
    nombreCurso           VARCHAR2(30)     NOT NULL,
    descripcionCurso      VARCHAR2(50)     NOT NULL,
    CONSTRAINT pk_curso PRIMARY KEY (clvCurso)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: DIAGNOSTICO 
--

CREATE TABLE DIAGNOSTICO(
    clvDiagnostico              NUMBER(38, 0)    NOT NULL,
    nombreDiagnostico           VARCHAR2(30)     NOT NULL,
    nivelGravedadDiagnostico    NUMBER(38, 0)    NOT NULL,
    descripcionDiagnostico      VARCHAR2(40)     NOT NULL,
    CONSTRAINT pk_diagnostico PRIMARY KEY (clvDiagnostico)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: EMPLEADO 
--

CREATE TABLE EMPLEADO(
    clvEmpleado           NUMBER(38, 0)    NOT NULL,
    clvSupervisorEmp      NUMBER(38, 0),
    rfcEmp                CHAR(12)         NOT NULL,
    curpEmp               CHAR(18)         NOT NULL,
    nombreEmp             CHAR(30)         NOT NULL,
    apPaternoEmp          CHAR(30)         NOT NULL,
    apMaternoEmp          CHAR(30)         NOT NULL,
    telefonoEmp           NUMBER(10, 0)    NOT NULL,
    edadEmp               NUMBER(38, 0)    NOT NULL,
    fotoEmp               BLOB         NOT NULL,
    fechaNacimientoEmp    DATE             NOT NULL,
    tipoEmpleado          NUMBER(38, 0)    NOT NULL,
    clvVeterinaria        NUMBER(38, 0)    NOT NULL,
    CONSTRAINT pk_empleado PRIMARY KEY (clvEmpleado)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs
lob (fotoEmp) store as (
    tablespace pet_care_blob_ts
);



-- 
-- TABLE: ESTADO 
--

CREATE TABLE ESTADO(
    clvEstado       NUMBER(38, 0)    NOT NULL,
    nombreEstado    CHAR(20)         NOT NULL,
    CONSTRAINT pk_estado PRIMARY KEY (clvEstado)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: ESTATUS_PROD_INVENTARIO 
--

CREATE TABLE ESTATUS_PROD_INVENTARIO(
    clvEstatusProdInventario     NUMBER(38, 0)    NOT NULL,
    estatusProdInventario        VARCHAR2(15)     NOT NULL,
    descripcionProdInventario    VARCHAR2(20)     NOT NULL,
    CONSTRAINT pk_estatus_productos_inventario PRIMARY KEY (clvEstatusProdInventario)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: ESTILISTA 
--

CREATE TABLE ESTILISTA(
    clvEstilista            NUMBER(38, 0)    NOT NULL,
    reseniaHabilidadesEst    CHAR(50)         NOT NULL,
    CONSTRAINT pk_estilistas PRIMARY KEY (clvEstilista)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: FOTO_MASCOTA 
--

CREATE TABLE FOTO_MASCOTA(
    clvFotoMascota    NUMBER(38, 0)    NOT NULL,
    clvMascota        NUMBER(38, 0)    NOT NULL,
    fotoMascota       BLOB         NOT NULL,
    CONSTRAINT pk_foto_mascota PRIMARY KEY (clvFotoMascota)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs
lob (fotoMascota) store as (
    tablespace pet_care_blob_ts
);



-- 
-- TABLE: HISTORICO_ESTATUS_PRODUCTOS 
--

CREATE TABLE HISTORICO_ESTATUS_PRODUCTOS(
    clvHistoricoEstatus           NUMBER(38, 0)    NOT NULL,
    clvInventarioVet              NUMBER(38, 0),
    clvEstatusProdInventario      NUMBER(38, 0),
    fechaCambioHistEstatusProd    DATE             NOT NULL,
    CONSTRAINT pk_historico_estatus_productos PRIMARY KEY (clvHistoricoEstatus)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: HISTORICO_PRECIO 
--

CREATE TABLE HISTORICO_PRECIO(
    clvHistoricoPrecio       NUMBER(38, 0)    NOT NULL,
    SKU                      VARCHAR2(20),
    fechaInicioHistPrecio    DATE             NOT NULL,
    fechaFinalHistPrecio     DATE             NOT NULL,
    precioHistPrecio         NUMBER(10, 2)    NOT NULL,
    CONSTRAINT plk_historico_precio PRIMARY KEY (clvHistoricoPrecio)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: INSCRIPCION_CURSO 
--

CREATE TABLE INSCRIPCION_CURSO(
    clvInscripcionCurso    NUMBER(38, 0)    NOT NULL,
    clvCurso               NUMBER(38, 0)    NOT NULL,
    clvEstilista           NUMBER(38, 0)    NOT NULL,
    CONSTRAINT pk_inscripcion_curso PRIMARY KEY (clvInscripcionCurso)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: INVENTARIO_VETERINARIA 
--

CREATE TABLE INVENTARIO_VETERINARIA(
    clvInventarioVet            NUMBER(38, 0)    NOT NULL,
    clvEstatusProdInventario    NUMBER(38, 0),
    clvVeterinaria              NUMBER(38, 0),
    SKU                         VARCHAR2(20),
    fechaInventarioVet          DATE             NOT NULL,
    CONSTRAINT pk_inventario_veterinaria PRIMARY KEY (clvInventarioVet)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: MASCOTA 
--

CREATE TABLE MASCOTA(
    clvMascota                NUMBER(38, 0)    NOT NULL,
    clvCliente                NUMBER(38, 0)    NOT NULL,
    razaMasc                  VARCHAR2(20)     NOT NULL,
    nombreMasc                VARCHAR2(20)     NOT NULL,
    pesoMasc                  NUMBER(6, 2)     NOT NULL,
    fechaNacimientoMasc       DATE             NOT NULL,
    edadMasc                  NUMBER(38, 0)    NOT NULL,
    razgosParticularesMasc    VARCHAR2(20)     NOT NULL,
    CONSTRAINT pk_mascota PRIMARY KEY (clvMascota)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: MASCOTA_PASEO 
--

CREATE TABLE MASCOTA_PASEO(
    clvMascotaPaseo    NUMBER(38, 0)    NOT NULL,
    clvPaseo           NUMBER(38, 0)    NOT NULL,
    clvMascota         NUMBER(38, 0)    NOT NULL,
    CONSTRAINT pk_mascota_paseo PRIMARY KEY (clvMascotaPaseo)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: MONITOREO_PASEO 
--

CREATE TABLE MONITOREO_PASEO(
    clvMonitoreoPaseo              NUMBER(38, 0)    NOT NULL,
    clvPaseo                       NUMBER(38, 0)    NOT NULL,
    latitudMonitoreoPaseo          NUMBER(9, 6)     NOT NULL,
    longitudMonitoreoPaseo         NUMBER(9, 6)     NOT NULL,
    fechaRegistroMonitoreoPaseo    DATE             NOT NULL,
    CONSTRAINT pk_monitoreo_paseo PRIMARY KEY (clvMonitoreoPaseo, clvPaseo)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: MUNICIPIO 
--

CREATE TABLE MUNICIPIO(
    clvMunicipio       NUMBER(38, 0)    NOT NULL,
    nombreMunicipio    CHAR(50)         NOT NULL,
    clvEstado          NUMBER(38, 0)    NOT NULL,
    CONSTRAINT pk_municipios PRIMARY KEY (clvMunicipio)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: ORDEN_COMPRA 
--

CREATE TABLE ORDEN_COMPRA(
    clvOrdenCompra                 NUMBER(38, 0)    NOT NULL,
    clvVendedorCompra              NUMBER(38, 0)    NOT NULL,
    clvClienteCompra               NUMBER(38, 0)    NOT NULL,
    fechaOrdenCompra               DATE             NOT NULL,
    importeServiciosOrdenCompra    NUMBER(10, 2)    NOT NULL,
    importeTotalOrdenCompra        NUMBER(10, 2)    NOT NULL,
    CONSTRAINT pk_orden_compra PRIMARY KEY (clvOrdenCompra)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: ORDEN_PRODUCTO 
--

CREATE TABLE ORDEN_PRODUCTO(
    clvOrdenProducto          NUMBER(38, 0)    NOT NULL,
    clvOrdenCompra            NUMBER(38, 0)    NOT NULL,
    SKU                       VARCHAR2(20)     NOT NULL,
    cantidadOrdenProductos    NUMBER(10, 2)    NOT NULL,
    CONSTRAINT pk_orden_producto PRIMARY KEY (clvOrdenProducto)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: PASEO 
--

CREATE TABLE PASEO(
    clvPaseo       NUMBER(38, 0)    NOT NULL,
    clvVendedor    NUMBER(38, 0)    NOT NULL,
    inicioPaseo    DATE             NOT NULL,
    finPaseo       DATE             NOT NULL,
    fechaPaseo     DATE             NOT NULL,
    CONSTRAINT pk_paseo PRIMARY KEY (clvPaseo)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: PRODUCTO 
--

CREATE TABLE PRODUCTO(
    SKU                     VARCHAR2(20)     NOT NULL,
    nombreProducto          CHAR(30)         NOT NULL,
    precioActualProducto    NUMBER(10, 2)    NOT NULL,
    clvCategoria            NUMBER(38, 0)    NOT NULL,
    CONSTRAINT pk_producto PRIMARY KEY (SKU)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: SERVICIO_ESTETICA 
--

create table servicio_estetica (
    clvservicioestetica       number(38, 0) not null,
    clvestilista              number(38, 0) not null,
    descripcionservicioest    varchar2(40) not null,
    precioservicioest         number(10, 2) not null,
    fechaservicioest          date not null,
    fotoantesest              blob not null,
    fotodespuesest            blob not null,
    clvmascota                number(38, 0) not null,
    constraint pk_servicio_estetica primary key (clvservicioestetica)
        using index tablespace pet_care_ix_ts
) 
tablespace pet_care_tbs
lob (fotoantesest, fotodespuesest) store as (
    tablespace pet_care_blob_ts
);




-- 
-- TABLE: TELEFONO_CLIENTE 
--

CREATE TABLE TELEFONO_CLIENTE(
    clvTelefono     NUMBER(38, 0)    NOT NULL,
    telefonoClie    NUMBER(10, 0)    NOT NULL,
    clvCliente      NUMBER(38, 0)    NOT NULL,
    CONSTRAINT pk_telefono_cliente PRIMARY KEY (clvTelefono)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: VENDEDOR 
--

CREATE TABLE VENDEDOR(
    clvVendedor         NUMBER(38, 0)    NOT NULL,
    horaEntradaVen      DATE             NOT NULL,
    horaSalidaVen       DATE             NOT NULL,
    numOrdenesMinVen    CHAR(10)         NOT NULL,
    gerenciaVendedor    CHAR(10)         NOT NULL,
    puedePasearVen      NUMBER(1, 0)     NOT NULL,
    CONSTRAINT pk_vendedor PRIMARY KEY (clvVendedor)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: VETERINARIA 
--

CREATE TABLE VETERINARIA(
    clvVeterinaria    NUMBER(38, 0)    NOT NULL,
    clvGerente        NUMBER(38, 0)    NOT NULL,
    latitudVet        NUMBER(9, 6)     NOT NULL,
    longitudVet       NUMBER(9, 6)     NOT NULL,
    horarioSemVet     VARCHAR2(50)     NOT NULL,
    horarioSabVet     VARCHAR2(50)     NOT NULL,
    domicilioVet      VARCHAR2(300)     NOT NULL,
    CONSTRAINT pk_veterinaria PRIMARY KEY (clvVeterinaria)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: VETERINARIO 
--

CREATE TABLE VETERINARIO(
    clvVeterinario          NUMBER(38, 0)    NOT NULL,
    cedulaProfesionalVet    CHAR(10)         NOT NULL,
    universidadVet          CHAR(30)         NOT NULL,
    fechaTitulacionVet      DATE             NOT NULL,
    CONSTRAINT pk_veterinario PRIMARY KEY (clvVeterinario)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;





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


