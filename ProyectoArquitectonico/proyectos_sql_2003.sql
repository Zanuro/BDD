CREATE TYPE T_jefe AS (
  codigo_jefe INTEGER,
  nombre VARCHAR(45),
  telefono VARCHAR(45)[],
  direccion VARCHAR(45)
);

CREATE TABLE jefe OF T_jefe (
  codigo_jefe PRIMARY KEY,
  nombre UNIQUE NOT NULL
);

CREATE TYPE T_proyecto AS (
  codigo_proyecto INTEGER,
  nombre VARCHAR(45),
  codigo_jefe REF T_jefe
);

CREATE TABLE proyecto OF T_proyecto (
  codigo_proyecto PRIMARY KEY,
  nombre UNIQUE,
  codigo_jefe UNIQUE NOT NULL
);

CREATE TYPE T_plano AS (
  id_plano INTEGER,
  fecha_entrega DATE,
  dibujo BLOB,
  cantidad_figuras INTEGER,
  arquitectos VARCHAR(45) ARRAY[5],
  codigo_proyecto REF T_proyecto
);

CREATE TABLE plano OF T_plano (
  id_plano PRIMARY KEY,
  fecha_entrega NOT NULL,
  dibujo NOT NULL
);

CREATE TYPE T_figura AS (
  id_figura INTEGER,
  nombre VARCHAR(45),
  color VARCHAR(45),
  area DOUBLE PRECISION,
  perimetro DOUBLE PRECISION,
  id_plano REF T_plano
);

CREATE TABLE figura OF T_figura (
  id_figura PRIMARY KEY,
  id_plano NOT NULL,
  nombre NOT NULL,
  color NOT NULL DEFAULT 'Blanco'
);

CREATE TYPE T_poligono UNDER T_figura (
  num_lineas INTEGER
);

CREATE TABLE poligono OF T_poligono (
  id_figura PRIMARY KEY
);

CREATE TYPE T_punto AS (
  x INTEGER,
  y INTEGER
);

CREATE TYPE T_linea AS (
  id_linea INTEGER,
  origen T_punto,
  destino T_punto,
  longitud DOUBLE PRECISION,
  id_figura REF T_poligono
);

CREATE TABLE linea OF T_linea (
  id_linea PRIMARY KEY,
  origen NOT NULL,
  destino NOT NULL,
  id_figura NOT NULL
);
