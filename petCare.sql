--@Autor: Martinez Martinez Francisco David
--@Fecha creación: 27/05/2025
--@Descripción: Creacion de Tablas y Foreings Keys  

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


CREATE TABLE PET_CARE_ADMIN.CATEGORIA(
    clvCategoria            NUMBER(38, 0)    NOT NULL,
    nombreCategoria         VARCHAR2(20)     NOT NULL,
    descripcionCategoria    VARCHAR2(30)     NOT NULL,
    CONSTRAINT pk_categoria PRIMARY KEY (clvCategoria)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;


-- 
-- TABLE: CERTIFICADO 
--

CREATE TABLE PET_CARE_ADMIN.CERTIFICADO(
    clvCursoAprobado            NUMBER(38, 0)    NOT NULL,
    clvInscripcionCurso         NUMBER(38, 0)    NOT NULL,
    nombreCertificado           VARCHAR2(30)     NOT NULL,
    certificadoPrueba           char(50)         NOT NULL,
    fechaAprobadoCertificado    DATE             NOT NULL,
    CONSTRAINT pk_certificado PRIMARY KEY (clvCursoAprobado)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: CLIENTE 
--

CREATE TABLE PET_CARE_ADMIN.CLIENTE(
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

CREATE TABLE PET_CARE_ADMIN.CONSULTA_MEDICA(
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

CREATE TABLE PET_CARE_ADMIN.CURSO(
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

CREATE TABLE PET_CARE_ADMIN.DIAGNOSTICO(
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

CREATE TABLE PET_CARE_ADMIN.EMPLEADO(
    clvEmpleado           NUMBER(38, 0)    NOT NULL,
    clvSupervisorEmp      NUMBER(38, 0),
    rfcEmp                CHAR(12)         NOT NULL,
    curpEmp               CHAR(18)         NOT NULL,
    nombreEmp             char(50)         NOT NULL,
    apPaternoEmp          char(50)         NOT NULL,
    apMaternoEmp          char(50)         NOT NULL,
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

CREATE TABLE PET_CARE_ADMIN.ESTADO(
    clvEstado       NUMBER(38, 0)    NOT NULL,
    nombreEstado    char(50)         NOT NULL,
    CONSTRAINT pk_estado PRIMARY KEY (clvEstado)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: ESTATUS_PROD_INVENTARIO 
--

CREATE TABLE PET_CARE_ADMIN.ESTATUS_PROD_INVENTARIO(
    clvEstatusProdInventario     NUMBER(38, 0)    NOT NULL,
    estatusProdInventario        VARCHAR2(15)     NOT NULL,
    descripcionProdInventario    VARCHAR2(20)     NOT NULL,
    CONSTRAINT pk_estatus_productos_inventario PRIMARY KEY (clvEstatusProdInventario)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: ESTILISTA 
--

CREATE TABLE PET_CARE_ADMIN.ESTILISTA(
    clvEstilista            NUMBER(38, 0)    NOT NULL,
    reseniaHabilidadesEst    CHAR(50)         NOT NULL,
    CONSTRAINT pk_estilistas PRIMARY KEY (clvEstilista)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: FOTO_MASCOTA 
--

CREATE TABLE PET_CARE_ADMIN.FOTO_MASCOTA(
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

CREATE TABLE PET_CARE_ADMIN.HISTORICO_ESTATUS_PRODUCTOS(
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

CREATE TABLE PET_CARE_ADMIN.HISTORICO_PRECIO(
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

CREATE TABLE PET_CARE_ADMIN.INSCRIPCION_CURSO(
    clvInscripcionCurso    NUMBER(38, 0)    NOT NULL,
    clvCurso               NUMBER(38, 0)    NOT NULL,
    clvEstilista           NUMBER(38, 0)    NOT NULL,
    CONSTRAINT pk_inscripcion_curso PRIMARY KEY (clvInscripcionCurso)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: INVENTARIO_VETERINARIA 
--

CREATE TABLE PET_CARE_ADMIN.INVENTARIO_VETERINARIA(
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

CREATE TABLE PET_CARE_ADMIN.MASCOTA(
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

CREATE TABLE PET_CARE_ADMIN.MASCOTA_PASEO(
    clvMascotaPaseo    NUMBER(38, 0)    NOT NULL,
    clvPaseo           NUMBER(38, 0)    NOT NULL,
    clvMascota         NUMBER(38, 0)    NOT NULL,
    CONSTRAINT pk_mascota_paseo PRIMARY KEY (clvMascotaPaseo)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: MONITOREO_PASEO 
--

CREATE TABLE PET_CARE_ADMIN.MONITOREO_PASEO(
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

CREATE TABLE PET_CARE_ADMIN.MUNICIPIO(
    clvMunicipio       NUMBER(38, 0)    NOT NULL,
    nombreMunicipio    CHAR(50)         NOT NULL,
    clvEstado          NUMBER(38, 0)    NOT NULL,
    CONSTRAINT pk_municipios PRIMARY KEY (clvMunicipio)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: ORDEN_COMPRA 
--

CREATE TABLE PET_CARE_ADMIN.ORDEN_COMPRA(
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

CREATE TABLE PET_CARE_ADMIN.ORDEN_PRODUCTO(
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

CREATE TABLE PET_CARE_ADMIN.PASEO(
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

CREATE TABLE PET_CARE_ADMIN.PRODUCTO(
    SKU                     VARCHAR2(20)     NOT NULL,
    nombreProducto          char(50)         NOT NULL,
    precioActualProducto    NUMBER(10, 2)    NOT NULL,
    clvCategoria            NUMBER(38, 0)    NOT NULL,
    CONSTRAINT pk_producto PRIMARY KEY (SKU)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: SERVICIO_ESTETICA 
--

create table PET_CARE_ADMIN.servicio_estetica (
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

CREATE TABLE PET_CARE_ADMIN.TELEFONO_CLIENTE(
    clvTelefono     NUMBER(38, 0)    NOT NULL,
    telefonoClie    NUMBER(10, 0)    NOT NULL,
    clvCliente      NUMBER(38, 0)    NOT NULL,
    CONSTRAINT pk_telefono_cliente PRIMARY KEY (clvTelefono)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: VENDEDOR 
--

CREATE TABLE PET_CARE_ADMIN.VENDEDOR(
    clvVendedor         NUMBER(38, 0)    NOT NULL,
    horaEntradaVen      DATE             NOT NULL,
    horaSalidaVen       DATE             NOT NULL,
    numOrdenesMinVen    char(50)         NOT NULL,
    gerenciaVendedor    char(50)         NOT NULL,
    puedePasearVen      NUMBER(1, 0)     NOT NULL,
    CONSTRAINT pk_vendedor PRIMARY KEY (clvVendedor)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;



-- 
-- TABLE: VETERINARIA 
--

CREATE TABLE PET_CARE_ADMIN.VETERINARIA(
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

CREATE TABLE PET_CARE_ADMIN.VETERINARIO(
    clvVeterinario          NUMBER(38, 0)    NOT NULL,
    cedulaProfesionalVet    char(50)         NOT NULL,
    universidadVet          char(50)         NOT NULL,
    fechaTitulacionVet      DATE             NOT NULL,
    CONSTRAINT pk_veterinario PRIMARY KEY (clvVeterinario)
using index tablespace pet_care_ix_ts
) tablespace pet_care_tbs;





--------------------------------------Fi tablas ---------------------------


