/*
  Estructura de la base de datos
*/

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
  codigo_jefe INTEGER
);

CREATE TABLE proyecto OF T_proyecto (
  codigo_proyecto PRIMARY KEY,
  nombre UNIQUE,
  codigo_jefe UNIQUE NOT NULL,
  CONSTRAINT fk_codigo_jefe
    FOREIGN KEY (codigo_jefe)
    REFERENCES jefe(codigo_jefe)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

CREATE TYPE T_plano AS (
  id_plano INTEGER,
  fecha_entrega DATE,
  dibujo BYTEA,
  cantidad_figuras INTEGER,
  arquitectos VARCHAR(45) ARRAY[5],
  codigo_proyecto INTEGER
);

CREATE TABLE plano OF T_plano (
  id_plano PRIMARY KEY,
  fecha_entrega NOT NULL,
  dibujo NOT NULL,
  CONSTRAINT fk_codigo_proyecto
    FOREIGN KEY (codigo_proyecto)
    REFERENCES proyecto(codigo_proyecto)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

CREATE TYPE T_figura AS (
  id_figura INTEGER,
  nombre VARCHAR(45),
  color VARCHAR(45),
  area DOUBLE PRECISION,
  perimetro DOUBLE PRECISION,
  id_plano INTEGER
);

CREATE TABLE figura OF T_figura (
  PRIMARY KEY (id_figura, id_plano),
  nombre NOT NULL,
  color NOT NULL DEFAULT 'Blanco',
  id_plano NOT NULL,
  CONSTRAINT fk_id_plano
    FOREIGN KEY (id_plano)
    REFERENCES plano(id_plano)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE poligono (
  num_lineas INTEGER,
  PRIMARY KEY (id_figura, id_plano)
) INHERITS(figura);

CREATE TYPE T_punto AS (
  x INTEGER,
  y INTEGER
);

CREATE TYPE T_linea AS (
  id_linea INTEGER,
  origen T_punto,
  destino T_punto,
  longitud DOUBLE PRECISION,
  id_figura INTEGER,
  id_plano INTEGER
);

CREATE TABLE linea OF T_linea (
  id_linea PRIMARY KEY,
  origen NOT NULL,
  destino NOT NULL,
  id_figura NOT NULL,
  id_plano NOT NULL,
  CONSTRAINT fk_id_figura
    FOREIGN KEY (id_figura, id_plano)
    REFERENCES poligono(id_figura, id_plano)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


/*
	Disparadores
*/

-- Calcular numero de figuras que tiene el plano

CREATE OR REPLACE FUNCTION calc_num_figuras()
RETURNS trigger AS $calc_num_figuras$
BEGIN
	IF (TG_OP = 'DELETE') THEN
		-- Contar figuras del plano al que pertenecia la figura eliminada
		UPDATE plano
		SET cantidad_figuras=(SELECT COUNT(*)
							FROM figura
							WHERE id_plano=OLD.id_plano)
		WHERE id_plano=OLD.id_plano;
		RETURN OLD;
	END IF;

	-- Contar figuras del plano
	UPDATE plano
	SET cantidad_figuras=(SELECT COUNT(*)
						FROM figura
						WHERE id_plano=NEW.id_plano)
	WHERE id_plano=NEW.id_plano;

	IF (TG_OP = 'UPDATE' AND OLD.id_plano <> NEW.id_plano) THEN
		-- Contar figuras del anterior plano al que pertenecia la figura modificada
	    UPDATE plano
		SET cantidad_figuras=(SELECT COUNT(*)
							FROM figura
							WHERE id_plano=OLD.id_plano)
		WHERE id_plano=OLD.id_plano;
  	END IF;

	RETURN NEW;
END;
$calc_num_figuras$ LANGUAGE plpgsql;

CREATE TRIGGER actualizar_cantidad_figuras_1
AFTER INSERT OR UPDATE OR DELETE ON figura
FOR EACH ROW
EXECUTE PROCEDURE calc_num_figuras();

CREATE TRIGGER actualizar_cantidad_figuras_2
AFTER INSERT OR UPDATE OR DELETE ON poligono
FOR EACH ROW
EXECUTE PROCEDURE calc_num_figuras();


-- Calcular numero de lineas que tiene el poligono

CREATE OR REPLACE FUNCTION calc_num_lines()
RETURNS trigger AS $calc_num_lines$
BEGIN
	IF (TG_OP = 'DELETE') THEN
		-- Contar lineas del poligono al que pertenecia la linea eliminada
		UPDATE poligono
		SET num_lineas=(SELECT COUNT(*)
						FROM linea
						WHERE id_figura=OLD.id_figura AND id_plano=OLD.id_plano)
		WHERE id_figura=OLD.id_figura AND id_plano=OLD.id_plano;
		RETURN OLD;
	END IF;

	-- Contar lineas del poligono
	UPDATE poligono
	SET num_lineas=(SELECT COUNT(*)
					FROM linea
					WHERE id_figura=NEW.id_figura AND id_plano=NEW.id_plano)
	WHERE id_figura=NEW.id_figura AND id_plano=NEW.id_plano;

	IF (TG_OP = 'UPDATE' AND ((OLD.id_figura <> NEW.id_figura) OR (OLD.id_plano <> NEW.id_plano))) THEN
		-- Contar lineas del anterior poligono al que pertenecia la linea modificada
	    UPDATE poligono
		SET num_lineas=(SELECT COUNT(*)
						FROM linea
						WHERE id_figura=OLD.id_figura AND id_plano=OLD.id_plano)
		WHERE id_figura=OLD.id_figura AND id_plano=OLD.id_plano;
  END IF;

	RETURN NEW;
END;
$calc_num_lines$ LANGUAGE plpgsql;

CREATE TRIGGER actualizar_num_lineas
AFTER INSERT OR UPDATE OR DELETE ON linea
FOR EACH ROW
EXECUTE PROCEDURE calc_num_lines();


-- Calcular longitud de las líneas

CREATE OR REPLACE FUNCTION calc_long()
RETURNS trigger AS $calc_long$
DECLARE
  total_distance DOUBLE PRECISION;
  interm1 INT;
  interm2 INT;
BEGIN
	interm1 := (NEW.destino).x - (NEW.origen).x;
	interm1 := POWER(interm1, 2);
	interm2 := (NEW.destino).y - (NEW.origen).y;
	interm2 := POWER(interm2, 2);
	total_distance := SQRT( interm1 + interm2 );

	NEW.longitud := total_distance;
	RETURN NEW;
END;
$calc_long$ LANGUAGE plpgsql;

CREATE TRIGGER calcular_longitud
BEFORE INSERT OR UPDATE ON linea
FOR EACH ROW
EXECUTE PROCEDURE calc_long();


-- Calcular area de figura (no se puede implementar por falta de datos),
-- siempre devuelve 1

CREATE OR REPLACE FUNCTION calc_area()
RETURNS trigger AS $calc_area$
BEGIN
	NEW.area := 1.0;
	RETURN NEW;
END;
$calc_area$ LANGUAGE plpgsql;

CREATE TRIGGER calcular_area_1
BEFORE INSERT OR UPDATE ON figura
FOR EACH ROW
EXECUTE PROCEDURE calc_area();

CREATE TRIGGER calcular_area_2
BEFORE INSERT OR UPDATE ON poligono
FOR EACH ROW
EXECUTE PROCEDURE calc_area();


-- Calcular perimetro de figuras que no son poligonos (no se puede implementar por falta de datos),
-- siempre devuelve 2

CREATE OR REPLACE FUNCTION calc_perimetro_figura()
RETURNS trigger AS $calc_perimetro_figura$
BEGIN
	NEW.perimetro := 2.0;
	RETURN NEW;
END;
$calc_perimetro_figura$ LANGUAGE plpgsql;


CREATE TRIGGER calcular_perimetro
BEFORE INSERT OR UPDATE ON figura
FOR EACH ROW
EXECUTE PROCEDURE calc_perimetro_figura();

-- Calcular perimetro de los poligonos

CREATE OR REPLACE FUNCTION calc_perimetro_poligono()
RETURNS trigger AS $calc_perimetro_poligono$
BEGIN
  IF (TG_OP = 'DELETE') THEN
    -- Actualizar perimetro del poligono al que pertenecia la linea eliminada
    UPDATE poligono
    SET perimetro = (SELECT SUM(longitud)
                  FROM linea
                  WHERE id_figura=OLD.id_figura AND id_plano=OLD.id_plano)
    WHERE id_figura=OLD.id_figura AND id_plano=OLD.id_plano;
    RETURN OLD;
  END IF;

  -- Actualizar perimetro del poligono
  UPDATE poligono
  SET perimetro = (SELECT SUM(longitud)
                  FROM linea
                  WHERE id_figura = NEW.id_figura AND id_plano = NEW.id_plano)
  WHERE id_figura=NEW.id_figura AND id_plano=NEW.id_plano;

  IF (TG_OP = 'UPDATE' AND ((OLD.id_figura <> NEW.id_figura) OR (OLD.id_plano <> NEW.id_plano))) THEN
		-- Calcular perimetro del anterior poligono al que pertenecia la linea modificada
    UPDATE poligono
		SET perimetro = (SELECT SUM(longitud)
						        FROM linea
						        WHERE id_figura=OLD.id_figura AND id_plano=OLD.id_plano)
		WHERE id_figura=OLD.id_figura AND id_plano=OLD.id_plano;
  END IF;

	RETURN NEW;
END;
$calc_perimetro_poligono$ LANGUAGE plpgsql;


CREATE TRIGGER calcular_perimetro_poligono
AFTER INSERT OR UPDATE OR DELETE ON linea
FOR EACH ROW
EXECUTE PROCEDURE calc_perimetro_poligono();


/*
  Datos
*/
START TRANSACTION;

INSERT INTO jefe VALUES (1,'Amancio Ortega', ARRAY['922100100','669100100'], 'Galicia');
INSERT INTO jefe VALUES (2,'Mark Zuckerberg', ARRAY['922200200','669200200'], 'EEUU');
INSERT INTO jefe VALUES (3,'Sauron', ARRAY['922300300','669300300'], 'Mordor');

COMMIT;


START TRANSACTION;

INSERT INTO proyecto VALUES (1, 'Centro de datos', 2);
INSERT INTO proyecto VALUES (2, 'Torre Oscura', 3);

COMMIT;


START TRANSACTION;

INSERT INTO plano VALUES (1, '2019-11-09', E'\\000', 0, ARRAY['Juan'], 1);
INSERT INTO plano VALUES (2, '2019-11-10', E'\\000', 0, ARRAY['Juan','Manuel'], 1);
INSERT INTO plano VALUES (3, '2019-11-11', E'\\000', 0, ARRAY['Antonio'], NULL);
INSERT INTO plano VALUES (4, '2019-11-12', E'\\000', 0, ARRAY['Balrog', 'Orco', 'Saruman', 'Troll', 'Dragon'], 2);

COMMIT;


START TRANSACTION;

INSERT INTO figura VALUES (1, 'figura 1', 'Blanco', 0.0, 0.0, 1);
INSERT INTO figura VALUES (1, 'figura 2', 'Negro', 0.0, 0.0, 2);
INSERT INTO figura VALUES (1, 'Ojo de Sauron', 'Rojo', 0.0, 0.0, 4);

COMMIT;


START TRANSACTION;

INSERT INTO poligono (id_figura, nombre, color, area, perimetro, id_plano, num_lineas)
VALUES (1, 'Triangulo 1', 'Blanco', 0.0, 0.0, 3, 0);

INSERT INTO poligono (id_figura, nombre, color, area, perimetro, id_plano, num_lineas)
VALUES (2, 'Triangulo 2', 'Blanco', 0.0, 0.0, 2, 0);

COMMIT;


START TRANSACTION;

INSERT INTO linea (id_linea, origen.x, origen.y, destino.x, destino.y, longitud, id_figura, id_plano)
VALUES (1, 0, 0, 2, 2, 0, 1, 3);
INSERT INTO linea (id_linea, origen.x, origen.y, destino.x, destino.y, longitud, id_figura, id_plano)
VALUES (2, 2, 2, 4, 0, 0, 1, 3);
INSERT INTO linea (id_linea, origen.x, origen.y, destino.x, destino.y, longitud, id_figura, id_plano)
VALUES (3, 0, 0, 4, 0, 0, 1, 3);
-- Otra forma de insertar en tipos compuestos
INSERT INTO linea VALUES (4, ROW(0,0), ROW(1,1), 0, 2, 2);
INSERT INTO linea VALUES (5, ROW(1,1), ROW(2,0), 0, 2, 2);
INSERT INTO linea VALUES (6, ROW(0,0), ROW(2,0), 0, 2, 2);

COMMIT;
