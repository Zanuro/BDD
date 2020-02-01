-- -----------------------------------------------------
-- Schema OAN
-- -----------------------------------------------------
DROP DATABASE IF EXISTS oan;
CREATE DATABASE oan ;
\c oan ;

-- -----------------------------------------------------
-- Table categoria
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS categoria (
  idCategoria SERIAL NOT NULL,
  nombre VARCHAR(20) NOT NULL,
  descripcion VARCHAR(60) NOT NULL,
  PRIMARY KEY (idCategoria))
;


-- -----------------------------------------------------
-- Table actor
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS actor (
  idActor SERIAL NOT NULL,
  nombre VARCHAR(30) NOT NULL,
  PRIMARY KEY (idActor))
;


-- -----------------------------------------------------
-- Table titulo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS titulo (
  idTitulo SERIAL NOT NULL,
  nombre VARCHAR(30) NOT NULL,
  año VARCHAR(4) NOT NULL,
  fecha_expiracion DATE NULL,
  valoracion DECIMAL(3,1) NOT NULL,
  duracion INT NOT NULL,
  precio DECIMAL(18,2) NOT NULL,
  descripcion VARCHAR(100) NOT NULL,
  calidad VARCHAR(20) NOT NULL,
  tipo VARCHAR(45) NOT NULL,
  CHECK (valoracion >= 0.0 AND valoracion <= 10.0),
  CHECK (duracion >= 0),
  PRIMARY KEY (idTitulo))
;


-- -----------------------------------------------------
-- Table usuario
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS usuario (
  email VARCHAR(45) NOT NULL,
  calle VARCHAR(45) NOT NULL,
  numero INT NOT NULL,
  codPostal INT NOT NULL,
  localidad VARCHAR(45) NOT NULL,
  provincia VARCHAR(45) NOT NULL,
  pais VARCHAR(45) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  apellidos VARCHAR(45) NOT NULL,
  PRIMARY KEY (email))
;

-- -----------------------------------------------------
-- Table suscripcion
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS suscripcion (
  idSuscripcion SERIAL NOT NULL,
  fecha_finalizacion DATE NOT NULL,
  num_descargas_max INT NOT NULL,
  tipo_suscripcion VARCHAR(15) NOT NULL,
  email VARCHAR(45) NOT NULL,
  CHECK (num_descargas_max >= 0),
  CHECK (tipo_suscripcion IN ('Basica', 'Premium', 'Contenido')),
  PRIMARY KEY (idSuscripcion),
  CONSTRAINT fk_01_suscripcion_email
    FOREIGN KEY (email)
    REFERENCES usuario (email)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
;

CREATE INDEX fk_suscripcion_1_idx ON suscripcion (email ASC);
-- -----------------------------------------------------
-- Table perfil
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS perfil (
  idPerfil SERIAL NOT NULL,
  nombre VARCHAR(20) NOT NULL,
  num_descargas_actuales INT NOT NULL DEFAULT 0,
  email VARCHAR(45) NOT NULL,
  idPendientes SERIAL NOT NULL UNIQUE,
  idFavoritos SERIAL NOT NULL UNIQUE,
  CHECK (num_descargas_actuales >= 0),
  PRIMARY KEY (idPerfil),
  CONSTRAINT fk_03_perfil_email
    FOREIGN KEY (email)
    REFERENCES usuario (email)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;

CREATE INDEX fk_perfil_1_idx ON perfil (email ASC);

CREATE UNIQUE INDEX idPendientes_UNIQUE ON perfil (idPendientes ASC);

CREATE UNIQUE INDEX idFavoritos_UNIQUE ON perfil (idFavoritos ASC);


-- -----------------------------------------------------
-- Table descargas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS descargas (
  idTitulo INT NOT NULL,
  fecha_caducidad DATE NOT NULL,
  idPerfil INT NOT NULL,
  PRIMARY KEY (idTitulo, idPerfil),
  CONSTRAINT fk_descargas_idTitulo
    FOREIGN KEY (idTitulo)
    REFERENCES titulo (idTitulo)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_descargas_idPerfil
    FOREIGN KEY (idPerfil)
    REFERENCES perfil (idPerfil)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;

CREATE INDEX fk_descargas_1_idx ON descargas (idTitulo ASC);

CREATE INDEX fk_descargas_2_idx ON descargas (idPerfil ASC);


-- -----------------------------------------------------
-- Table titulo_categoria
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS titulo_categoria (
  idCategoria INT NOT NULL,
  idTitulo INT NOT NULL,
  PRIMARY KEY (idCategoria, idTitulo),
  CONSTRAINT fk_titulo_categoria_idCategoria
    FOREIGN KEY (idCategoria)
    REFERENCES categoria (idCategoria)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_titulo_categoria_idTitulo
    FOREIGN KEY (idTitulo)
    REFERENCES titulo (idTitulo)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;

CREATE INDEX fk_titulo_categoria_2_idx ON titulo_categoria (idTitulo ASC);


-- -----------------------------------------------------
-- Table actor_titulo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS actor_titulo (
  idActor INT NOT NULL,
  idTitulo INT NOT NULL,
  PRIMARY KEY (idActor, idTitulo),
  CONSTRAINT fk_actor_titulo_idActor
    FOREIGN KEY (idActor)
    REFERENCES actor (idActor)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_actor_titulo_idTitulo
    FOREIGN KEY (idTitulo)
    REFERENCES titulo (idTitulo)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;

CREATE INDEX fk_actor_titulo_2_idx ON actor_titulo (idTitulo ASC);


-- -----------------------------------------------------
-- Table serie
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS serie (
  idSerie SERIAL NOT NULL,
  nombre VARCHAR(20) NOT NULL,
  descripcion VARCHAR(150) NOT NULL,
  PRIMARY KEY (idSerie))
;


-- -----------------------------------------------------
-- Table factura
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS factura (
  idFactura SERIAL NOT NULL,
  fecha_factura DATE NOT NULL,
  importe DECIMAL(18,2) NOT NULL,
  idSuscripcion INT NOT NULL,
  PRIMARY KEY (idFactura),
  CONSTRAINT fk_factura_idSuscripcion
    FOREIGN KEY (idSuscripcion)
    REFERENCES suscripcion (idSuscripcion)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
;

CREATE INDEX fk_factura_suscripcion_idx ON factura (idSuscripcion ASC);


-- -----------------------------------------------------
-- Table pago
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS pago (
  idPago SERIAL NOT NULL,
  fecha DATE NOT NULL,
  metodo_pago VARCHAR(45) NULL,
  nombre VARCHAR(45) NULL,
  num_tarjeta VARCHAR(45) NULL,
  CVC VARCHAR(45) NULL,
  fecha_vencimiento DATE NULL,
  tipo_pago VARCHAR(45) NULL,
  idFactura INT NOT NULL,
  PRIMARY KEY (idPago),
  CONSTRAINT fk_pago_idFactura
    FOREIGN KEY (idFactura)
    REFERENCES factura (idFactura)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
;

CREATE INDEX fk_pago_1_idx ON pago (idFactura ASC);


-- -----------------------------------------------------
-- Table empleado
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS empleado (
  idEmpleado SERIAL NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (idEmpleado))
;


-- -----------------------------------------------------
-- Table reporte
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS reporte (
  idReporte SERIAL NOT NULL,
  descripcion VARCHAR(150) NOT NULL,
  estado VARCHAR(20) NULL,
  email VARCHAR(45) NOT NULL,
  PRIMARY KEY (idReporte),
  CONSTRAINT fk_02_reporte_email
    FOREIGN KEY (email)
    REFERENCES usuario (email)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
;

CREATE INDEX fk_reporte_1_idx ON reporte (email ASC);


-- -----------------------------------------------------
-- Table reporte_empleado
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS reporte_empleado (
  idEmpleado INT NOT NULL,
  idReporte INT NOT NULL,
  PRIMARY KEY (idEmpleado, idReporte),
  CONSTRAINT fk_reporte_empleado_idEmpleado
    FOREIGN KEY (idEmpleado)
    REFERENCES empleado (idEmpleado)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_reporte_empleado_idReporte
    FOREIGN KEY (idReporte)
    REFERENCES reporte (idReporte)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
;

CREATE INDEX fk_reporte_empleado_2_idx ON reporte_empleado (idReporte ASC);


-- -----------------------------------------------------
-- Table redsocial
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS redsocial (
  nombre VARCHAR(30) NOT NULL,
  tipo_red_social VARCHAR(20) NOT NULL,
  idPerfil INT NOT NULL,
  CHECK (tipo_red_social IN ('Facebook', 'Twitter')),
  PRIMARY KEY (idPerfil, tipo_red_social),
  CONSTRAINT fk_redsocial_idPerfil
    FOREIGN KEY (idPerfil)
    REFERENCES perfil (idPerfil)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;

CREATE INDEX fk_redsocial_1_idx ON redsocial (idPerfil ASC);


-- -----------------------------------------------------
-- Table perfil_perfil
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS perfil_perfil (
  idPerfil INT NOT NULL,
  idPerfilAmigo INT NOT NULL,
  PRIMARY KEY (idPerfil, idPerfilAmigo),
  CONSTRAINT fk_perfil_perfil_idPerfil
    FOREIGN KEY (idPerfil)
    REFERENCES perfil (idPerfil)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_perfil_perfil_idPerfilAmigo
    FOREIGN KEY (idPerfilAmigo)
    REFERENCES perfil (idPerfil)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;

CREATE INDEX fk_perfil_perfil_2_idx ON perfil_perfil (idPerfilAmigo ASC);


-- -----------------------------------------------------
-- Table perfil_comenta_titulo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS perfil_comenta_titulo (
  idPerfil INT NOT NULL,
  idTitulo INT NOT NULL,
  fecha TIMESTAMP NOT NULL,
  comentario VARCHAR(150) NOT NULL,
  PRIMARY KEY (idPerfil, idTitulo, fecha),
  CONSTRAINT fk_perfil_comenta_titulo_idPerfil
    FOREIGN KEY (idPerfil)
    REFERENCES perfil (idPerfil)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_perfil_comenta_titulo_idTitulo
    FOREIGN KEY (idTitulo)
    REFERENCES titulo (idTitulo)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;

CREATE INDEX fk_perfil_comenta_titulo_2_idx ON perfil_comenta_titulo (idTitulo ASC);


-- -----------------------------------------------------
-- Table perfil_visualiza_titulo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS perfil_visualiza_titulo (
  idPerfil INT NOT NULL,
  idTitulo INT NOT NULL,
  momento_actual INT NOT NULL DEFAULT 0,
  visto BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (idPerfil, idTitulo),
  CONSTRAINT fk_perfil_visualiza_titulo_idPerfil
    FOREIGN KEY (idPerfil)
    REFERENCES perfil (idPerfil)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_perfil_visualiza_titulo_idTitulo
    FOREIGN KEY (idTitulo)
    REFERENCES titulo (idTitulo)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;

CREATE INDEX fk_perfil_visualiza_titulo_2_idx ON perfil_visualiza_titulo (idTitulo ASC);


-- -----------------------------------------------------
-- Table favoritos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS favoritos (
  idFavoritos INT NOT NULL,
  idTitulo INT NOT NULL,
  PRIMARY KEY (idFavoritos, idTitulo),
  CONSTRAINT fk_favoritos_idTitulo
    FOREIGN KEY (idTitulo)
    REFERENCES titulo (idTitulo)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_favoritos_idFavoritos
    FOREIGN KEY (idFavoritos)
    REFERENCES perfil (idFavoritos)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;

CREATE INDEX fk_favoritos_idTitulo_idx ON favoritos (idTitulo ASC);


-- -----------------------------------------------------
-- Table pendientes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS pendientes (
  idPendientes INT NOT NULL,
  idTitulo INT NOT NULL,
  PRIMARY KEY (idPendientes, idTitulo),
  CONSTRAINT fk_pendientes_idTitulo
    FOREIGN KEY (idTitulo)
    REFERENCES titulo (idTitulo)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_pendientes_idPendientes
    FOREIGN KEY (idPendientes)
    REFERENCES perfil (idPendientes)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;

CREATE INDEX fk_pendientes_1_idx ON pendientes (idTitulo ASC);


-- -----------------------------------------------------
-- Table titulo_serie
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS titulo_serie (
  idTitulo INT NOT NULL,
  capitulo INT NOT NULL,
  temporada INT NOT NULL,
  idSerie INT NOT NULL,
  PRIMARY KEY (idTitulo),
  CONSTRAINT fk_titulo_serie_idSerie
    FOREIGN KEY (idSerie)
    REFERENCES serie (idSerie)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_titulo_serie_idTitulo
    FOREIGN KEY (idTitulo)
    REFERENCES titulo (idTitulo)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;

CREATE INDEX fk_titulo_serie_serie_idx ON titulo_serie (idSerie ASC);


-- -----------------------------------------------------
-- Table idioma
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS idioma (
  idIdioma SERIAL NOT NULL,
  nombre VARCHAR(45) NOT NULL UNIQUE,
  PRIMARY KEY (idIdioma))
;

CREATE UNIQUE INDEX nombre_UNIQUE ON idioma (nombre ASC);


-- -----------------------------------------------------
-- Table subtitulo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS subtitulo (
  idTitulo INT NOT NULL,
  idIdioma INT NOT NULL,
  PRIMARY KEY (idTitulo, idIdioma),
  CONSTRAINT fk_subtitulo_idTitulo
    FOREIGN KEY (idTitulo)
    REFERENCES titulo (idTitulo)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_subtitulo_idIdioma
    FOREIGN KEY (idIdioma)
    REFERENCES idioma (idIdioma)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;

CREATE INDEX fk_subtitulo_idioma_idx ON subtitulo (idIdioma ASC);


-- -----------------------------------------------------
-- Table titulo_idioma
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS titulo_idioma (
  idTitulo INT NOT NULL,
  idIdioma INT NOT NULL,
  PRIMARY KEY (idTitulo, idIdioma),
  CONSTRAINT fk_titulo_idioma_idTitulo
    FOREIGN KEY (idTitulo)
    REFERENCES titulo (idTitulo)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_titulo_idioma_idIdioma
    FOREIGN KEY (idIdioma)
    REFERENCES idioma (idIdioma)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
;

CREATE INDEX fk_titulo_idioma_idIdioma_idx ON titulo_idioma (idIdioma ASC);