-- MySQL Script generated by MySQL Workbench
-- mar 05 nov 2019 12:27:15 WET
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

/*
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
*/

-- -----------------------------------------------------
-- Schema viveros
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema viveros
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS viveros ;
\c viveros ;

-- -----------------------------------------------------
-- Table vivero
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS vivero (
  localidad VARCHAR(45) NOT NULL,
  coordenadas VARCHAR(45) NOT NULL,
  PRIMARY KEY (coordenadas))
;


-- -----------------------------------------------------
-- Table zona
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS zona (
  nombre VARCHAR(45) NOT NULL,
  coordenadas VARCHAR(45) NOT NULL,
  PRIMARY KEY (nombre, coordenadas),
  CONSTRAINT fk_zona_vivero
    FOREIGN KEY (coordenadas)
    REFERENCES vivero (coordenadas)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
;


-- -----------------------------------------------------
-- Table empleado
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS empleado (
  dni VARCHAR(9) NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  css VARCHAR(45) NOT NULL,
  sueldo DECIMAL(18,2) NOT NULL,
  antiguedad DATE NOT NULL,
  PRIMARY KEY (dni),
  CONSTRAINT css_UNIQUE UNIQUE (css))
;


-- -----------------------------------------------------
-- Table producto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS producto (
  codigo VARCHAR(15) NOT NULL,
  descripcion VARCHAR(45) NULL,
  precio DECIMAL(18,2) NULL,
  stock INTEGER NULL,
  PRIMARY KEY (codigo))
;


-- -----------------------------------------------------
-- Table cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS cliente (
  dni VARCHAR(9) NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  bonificación DECIMAL(18,2) NULL DEFAULT 0,
  total_mensual DECIMAL(18,2) NULL DEFAULT 0,
  PRIMARY KEY (dni))
;


-- -----------------------------------------------------
-- Table producto_zona
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS producto_zona (
  codigo VARCHAR(15) NOT NULL,
  nombre_zona VARCHAR(45) NOT NULL,
  coordenadas VARCHAR(45) NOT NULL,
  cantidad INTEGER NOT NULL,
  PRIMARY KEY (codigo, coordenadas, nombre_zona),
  CONSTRAINT fk_producto_zona_zona
    FOREIGN KEY (nombre_zona , coordenadas)
    REFERENCES zona (nombre , coordenadas)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_producto_zona_producto
    FOREIGN KEY (codigo)
    REFERENCES producto (codigo)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
;


-- -----------------------------------------------------
-- Table cliente_compra_producto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS cliente_compra_producto (
  dni_cliente VARCHAR(9) NOT NULL,
  codigo VARCHAR(15) NOT NULL,
  cantidad INTEGER NOT NULL,
  fecha TIMESTAMP NOT NULL,
  dni_empleado VARCHAR(9) NOT NULL,
  PRIMARY KEY (dni_cliente, codigo, fecha),
  CONSTRAINT fk_cliente_compra_producto_cliente
    FOREIGN KEY (dni_cliente)
    REFERENCES cliente (dni)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_cliente_compra_producto_empleado
    FOREIGN KEY (dni_empleado)
    REFERENCES empleado (dni)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_cliente_compra_producto_producto
    FOREIGN KEY (codigo)
    REFERENCES producto (codigo)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
;


-- -----------------------------------------------------
-- Table empleado_trabaja_zona
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS empleado_trabaja_zona (
  dni VARCHAR(9) NOT NULL,
  nombre_zona VARCHAR(45) NOT NULL,
  coordenadas VARCHAR(45) NOT NULL,
  fecha_ini DATE NOT NULL,
  fecha_fin DATE NULL,
  ventas DECIMAL(18,2) NULL DEFAULT 0,
  PRIMARY KEY (dni, fecha_ini, nombre_zona, coordenadas),
  CONSTRAINT fk_empleado_trabaja_zona_empleado
    FOREIGN KEY (dni)
    REFERENCES empleado (dni)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_empleado_trabaja_zona_zona
    FOREIGN KEY (nombre_zona , coordenadas)
    REFERENCES zona (nombre , coordenadas)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
;

/*
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
*/

-- -----------------------------------------------------
-- Data for table vivero
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO vivero (localidad, coordenadas) VALUES ('La Laguna', '28°29''N 16°19''O');
INSERT INTO vivero (localidad, coordenadas) VALUES ('S/C de Tenerife', '28°28''00"N 16°15''00"O');
INSERT INTO vivero (localidad, coordenadas) VALUES ('La Matanza', '34°43''00"S 58°38''00"O');
INSERT INTO vivero (localidad, coordenadas) VALUES ('Arafo', '28°20''26"N 16°25''02"O');

COMMIT;


-- -----------------------------------------------------
-- Data for table zona
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO zona (nombre, coordenadas) VALUES ('Almacen', '28°29''N 16°19''O');
INSERT INTO zona (nombre, coordenadas) VALUES ('Entrada', '28°29''N 16°19''O');
INSERT INTO zona (nombre, coordenadas) VALUES ('Almacen', '28°28''00"N 16°15''00"O');
INSERT INTO zona (nombre, coordenadas) VALUES ('Entrada', '28°28''00"N 16°15''00"O');

COMMIT;

-- -----------------------------------------------------
-- Data for table producto
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO producto (codigo, descripcion, precio, stock) VALUES ('1234', 'Helecho', 7.15, 0);
INSERT INTO producto (codigo, descripcion, precio, stock) VALUES ('2323', 'Orquidea', 10.22, 0);
INSERT INTO producto (codigo, descripcion, precio, stock) VALUES ('9999', 'Tierra 10 kg.', 2.30, 0);
INSERT INTO producto (codigo, descripcion, precio, stock) VALUES ('1010', 'Abono 10 kg.', 9.21, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table cliente
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO cliente (dni, nombre, bonificación, total_mensual) VALUES ('45454545B', 'lo platamos todo SL', 0, 0);
INSERT INTO cliente (dni, nombre, bonificación, total_mensual) VALUES ('56565656B', 'El Plantón SLU', 0, 0);
INSERT INTO cliente (dni, nombre, bonificación, total_mensual) VALUES ('78787878E', 'José de la Rosa', 0, 0);
INSERT INTO cliente (dni, nombre, bonificación, total_mensual) VALUES ('99999999M', 'Amancio Ortega', 0, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table empleado
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO empleado (dni, nombre, css, sueldo, antiguedad) VALUES ('12345678A', 'Maria', '111111111111', 1000.00, '2019-01-10');
INSERT INTO empleado (dni, nombre, css, sueldo, antiguedad) VALUES ('87654321B', 'Cristina', '222222222222', 1000.00, '2019-02-15');
INSERT INTO empleado (dni, nombre, css, sueldo, antiguedad) VALUES ('12121212C', 'Antonio', '333333333333', 900.00, '2019-03-14');
INSERT INTO empleado (dni, nombre, css, sueldo, antiguedad) VALUES ('21212121D', 'Manuel', '444444444444', 900.00, '2019-03-16');

COMMIT;



-- -----------------------------------------------------
-- Data for table producto_zona
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO producto_zona (codigo, nombre_zona, coordenadas, cantidad) VALUES ('1234', 'Entrada', '28°28''00"N 16°15''00"O', 10);
INSERT INTO producto_zona (codigo, nombre_zona, coordenadas, cantidad) VALUES ('2323', 'Entrada', '28°28''00"N 16°15''00"O', 5);
INSERT INTO producto_zona (codigo, nombre_zona, coordenadas, cantidad) VALUES ('9999', 'Almacen', '28°28''00"N 16°15''00"O', 20);
INSERT INTO producto_zona (codigo, nombre_zona, coordenadas, cantidad) VALUES ('1010', 'Almacen', '28°28''00"N 16°15''00"O', 20);
INSERT INTO producto_zona (codigo, nombre_zona, coordenadas, cantidad) VALUES ('1234', 'Entrada', '28°29''N 16°19''O', 11);
INSERT INTO producto_zona (codigo, nombre_zona, coordenadas, cantidad) VALUES ('2323', 'Entrada', '28°29''N 16°19''O', 5);
INSERT INTO producto_zona (codigo, nombre_zona, coordenadas, cantidad) VALUES ('9999', 'Almacen', '28°29''N 16°19''O', 30);
INSERT INTO producto_zona (codigo, nombre_zona, coordenadas, cantidad) VALUES ('1010', 'Almacen', '28°29''N 16°19''O', 35);

COMMIT;


-- -----------------------------------------------------
-- Data for table cliente_compra_producto
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO cliente_compra_producto (dni_cliente, codigo, cantidad, fecha, dni_empleado) VALUES ('56565656B', '9999', 5, '2019-04-11 10:00:00', '12345678A');
INSERT INTO cliente_compra_producto (dni_cliente, codigo, cantidad, fecha, dni_empleado) VALUES ('56565656B', '9999', 1, '2019-04-11 10:05:10', '12345678A');
INSERT INTO cliente_compra_producto (dni_cliente, codigo, cantidad, fecha, dni_empleado) VALUES ('45454545B', '1010', 3, '2019-04-11 10:00:00', '87654321B');
INSERT INTO cliente_compra_producto (dni_cliente, codigo, cantidad, fecha, dni_empleado) VALUES ('78787878E', '1234', 1, '2019-04-11 10:35:00', '87654321B');

COMMIT;


-- -----------------------------------------------------
-- Data for table empleado_trabaja_zona
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO empleado_trabaja_zona (dni, nombre_zona, coordenadas, fecha_ini, fecha_fin, ventas) VALUES ('12345678A', 'Entrada', '28°29''N 16°19''O', '2019-01-10', NULL, 0);
INSERT INTO empleado_trabaja_zona (dni, nombre_zona, coordenadas, fecha_ini, fecha_fin, ventas) VALUES ('12121212C', 'Almacen', '28°29''N 16°19''O', '2019-03-14', NULL, 0);
INSERT INTO empleado_trabaja_zona (dni, nombre_zona, coordenadas, fecha_ini, fecha_fin, ventas) VALUES ('87654321B', 'Entrada', '28°28''00"N 16°15''00"O', '2019-02-15', NULL, 0);
INSERT INTO empleado_trabaja_zona (dni, nombre_zona, coordenadas, fecha_ini, fecha_fin, ventas) VALUES ('21212121D', 'Almacen', '28°28''00"N 16°15''00"O', '2019-03-16', NULL, 0);

COMMIT;

