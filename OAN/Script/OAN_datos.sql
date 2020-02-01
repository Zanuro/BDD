-- -----------------------------------------------------
-- Datos tabla categoria
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO categoria (nombre, descripcion) VALUES ('Accion', 'Muchas explosiones y disparos');
INSERT INTO categoria (nombre, descripcion) VALUES ('Comedia', 'Jajajaja');
INSERT INTO categoria (nombre, descripcion) VALUES ('Artes Marciales', 'Pim Pam Pum');
INSERT INTO categoria (nombre, descripcion) VALUES ('Drama', 'Chiquita angustia');
INSERT INTO categoria (nombre, descripcion) VALUES ('Doc. Naturaleza', 'Vida salvaje');

COMMIT;


-- -----------------------------------------------------
-- Datos tabla actor
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO actor (nombre) VALUES ('Will Smith');
INSERT INTO actor (nombre) VALUES ('Matthew Fox');
INSERT INTO actor (nombre) VALUES ('Scarlett Johansson');
INSERT INTO actor (nombre) VALUES ('Jennifer Aniston');
INSERT INTO actor (nombre) VALUES ('Evangeline Lilly');

COMMIT;


-- -----------------------------------------------------
-- Datos tabla titulo
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO titulo (nombre, año, valoracion, duracion, precio, descripcion, calidad, tipo)
VALUES ('Bad Boys for Life', 2020, 6.2, 90, 9.99, 'Dos policías muy locos', '1080', 'Pelicula');

INSERT INTO titulo (nombre, año, valoracion, duracion, precio, descripcion, calidad, tipo)
VALUES ('La tierra es plana', 2018, 7.0, 109, 3.00, 'Explora la comunidad de creyentes del terraplanismo', '720', 'Documental');

INSERT INTO titulo (nombre, año, valoracion, duracion, precio, descripcion, calidad, tipo)
VALUES ('Historia de dos ciudades', 2006, 9.0, 43, 0.50, 'Locke necesita respuestas a sus sueños y decide realizar un viaje espiritual a su subconsciente', '480', 'Serie');

COMMIT;


-- -----------------------------------------------------
-- Datos tabla usuario
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO usuario (email, calle, numero, codPostal, localidad, provincia, pais, fecha_nacimiento, nombre, apellidos)
VALUES ('antonio.gutierrez1984@gmail.com', 'Herradores', 1, 38100, 'La Laguna', 'S/C de Tenerife', 'España', '1984-09-23', 'Antonio', 'Gutierrez Afonso');

INSERT INTO usuario (email, calle, numero, codPostal, localidad, provincia, pais, fecha_nacimiento, nombre, apellidos)
VALUES ('julia.almeida@gmail.com', 'Alcala', 4, 28014, 'Madrid', 'Madrid', 'España', '2000-01-11', 'Julia', 'Almeida Rodriguez');

INSERT INTO usuario (email, calle, numero, codPostal, localidad, provincia, pais, fecha_nacimiento, nombre, apellidos)
VALUES ('victoria.md@gmail.com', 'Rambla de Cataluña', 202, 08007, 'Barcelona', 'Barcelona', 'España', '2001-02-22', 'Victoria', 'Martin Delgado');

COMMIT;


-- -----------------------------------------------------
-- Datos tabla suscripcion
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO suscripcion (fecha_finalizacion, num_descargas_max, tipo_suscripcion, email)
VALUES ('2020-01-01', 2, 'Premium', 'antonio.gutierrez1984@gmail.com');

INSERT INTO suscripcion (fecha_finalizacion, num_descargas_max, tipo_suscripcion, email)
VALUES ('2021-01-01', 2, 'Premium', 'antonio.gutierrez1984@gmail.com');

INSERT INTO suscripcion (fecha_finalizacion, num_descargas_max, tipo_suscripcion, email)
VALUES ('2020-06-01', 0, 'Basica', 'julia.almeida@gmail.com');

INSERT INTO suscripcion (fecha_finalizacion, num_descargas_max, tipo_suscripcion, email)
VALUES ('2020-05-30', 4, 'Contenido', 'victoria.md@gmail.com');

COMMIT;


-- -----------------------------------------------------
-- Datos tabla perfil
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO perfil (nombre, email) VALUES ('Antonio', 'antonio.gutierrez1984@gmail.com');
INSERT INTO perfil (nombre, email) VALUES ('Toni', 'antonio.gutierrez1984@gmail.com');
INSERT INTO perfil (nombre, email) VALUES ('Julia', 'julia.almeida@gmail.com');
INSERT INTO perfil (nombre, email) VALUES ('Vicky', 'victoria.md@gmail.com');

COMMIT;


-- -----------------------------------------------------
-- Datos tabla descargas
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO descargas (idTitulo, fecha_caducidad, idPerfil) VALUES (3, CURRENT_DATE + 1, 1);
INSERT INTO descargas (idTitulo, fecha_caducidad, idPerfil) VALUES (3, CURRENT_DATE + 4, 2);
INSERT INTO descargas (idTitulo, fecha_caducidad, idPerfil) VALUES (2, CURRENT_DATE + 10, 4);

COMMIT;


-- -----------------------------------------------------
-- Datos tabla titulo_categoria
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO titulo_categoria (idCategoria, idTitulo) VALUES (1, 1);
INSERT INTO titulo_categoria (idCategoria, idTitulo) VALUES (2, 1);
INSERT INTO titulo_categoria (idCategoria, idTitulo) VALUES (5, 2);
INSERT INTO titulo_categoria (idCategoria, idTitulo) VALUES (4, 3);

COMMIT;


-- -----------------------------------------------------
-- Datos tabla actor_titulo
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO actor_titulo (idActor, idTitulo) VALUES (1, 1);
INSERT INTO actor_titulo (idActor, idTitulo) VALUES (3, 2);
INSERT INTO actor_titulo (idActor, idTitulo) VALUES (4, 2);
INSERT INTO actor_titulo (idActor, idTitulo) VALUES (2, 3);
INSERT INTO actor_titulo (idActor, idTitulo) VALUES (5, 3);

COMMIT;


-- -----------------------------------------------------
-- Datos tabla serie
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO serie (nombre, descripcion) 
VALUES ('Lost', 'El vuelo 815 se estrella en una isla desierta, exuberante y misteriosa...');

INSERT INTO serie (nombre, descripcion)
VALUES ('Juego de Tronos', 'Basada en los libros de George R.R. Martin');

COMMIT;


-- -----------------------------------------------------
-- Datos tabla factura
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO factura (fecha_factura, importe, idSuscripcion) VALUES ('2019-12-01', 18.00, 1);
INSERT INTO factura (fecha_factura, importe, idSuscripcion) VALUES ('2020-01-01', 18.00, 2);
INSERT INTO factura (fecha_factura, importe, idSuscripcion) VALUES ('2020-01-01', 9.00, 3);
INSERT INTO factura (fecha_factura, importe, idSuscripcion) VALUES (CURRENT_DATE, 3.00, 4);

COMMIT;


-- -----------------------------------------------------
-- Datos tabla pago
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO pago (fecha, metodo_pago, num_tarjeta, CVC, idFactura)
VALUES ('2019-12-02', 'Tajerta', '1111 2222 3333 4444', '123', 1);

INSERT INTO pago (fecha, metodo_pago, num_tarjeta, CVC, idFactura)
VALUES ('2020-01-01', 'Tajerta', '1111 2222 3333 4444', '123', 2);

INSERT INTO pago (fecha, metodo_pago, num_tarjeta, CVC, idFactura)
VALUES (CURRENT_DATE, 'Tajerta', '4000 2000 5000 1234', '432', 4);

COMMIT;


-- -----------------------------------------------------
-- Datos tabla empleado
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO empleado (nombre) VALUES ('Marco');
INSERT INTO empleado (nombre) VALUES ('Maria');
INSERT INTO empleado (nombre) VALUES ('Luis');

COMMIT;


-- -----------------------------------------------------
-- Datos tabla reporte
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO reporte (descripcion, estado, email)
VALUES ('Error al reproducir el video', 'Cerrado', 'antonio.gutierrez1984@gmail.com');

INSERT INTO reporte (descripcion, estado, email)
VALUES ('A veces no se escucha el audio', 'Abierto', 'julia.almeida@gmail.com');

COMMIT;


-- -----------------------------------------------------
-- Datos tabla reporte_empleado
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO reporte_empleado (idEmpleado, idReporte) VALUES (1, 1);
INSERT INTO reporte_empleado (idEmpleado, idReporte) VALUES (1, 2);
INSERT INTO reporte_empleado (idEmpleado, idReporte) VALUES (2, 2);

COMMIT;


-- -----------------------------------------------------
-- Datos tabla redsocial
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO redsocial (nombre, tipo_red_social, idPerfil) VALUES ('Antonio', 'Facebook', 1);
INSERT INTO redsocial (nombre, tipo_red_social, idPerfil) VALUES ('AntonioTwitter', 'Twitter', 1);
INSERT INTO redsocial (nombre, tipo_red_social, idPerfil) VALUES ('Julia_2000', 'Twitter', 3);
INSERT INTO redsocial (nombre, tipo_red_social, idPerfil) VALUES ('Vicky', 'Facebook', 4);

COMMIT;


-- -----------------------------------------------------
-- Datos tabla perfil_perfil
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO perfil_perfil (idPerfil, idPerfilAmigo) VALUES (2, 1);
INSERT INTO perfil_perfil (idPerfil, idPerfilAmigo) VALUES (1, 2);

COMMIT;


-- -----------------------------------------------------
-- Datos tabla perfil_visualiza_titulo
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO perfil_visualiza_titulo (idPerfil, idTitulo, momento_actual)
VALUES (1, 1, 5390);

INSERT INTO perfil_visualiza_titulo (idPerfil, idTitulo, momento_actual)
VALUES (2, 3, 600);

INSERT INTO perfil_visualiza_titulo (idPerfil, idTitulo, momento_actual)
VALUES (3, 1, 5310);

INSERT INTO perfil_visualiza_titulo (idPerfil, idTitulo, momento_actual)
VALUES (4, 2, 4500);

COMMIT;


-- -----------------------------------------------------
-- Datos tabla perfil_comenta_titulo
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO perfil_comenta_titulo (idPerfil, idTitulo, fecha, comentario)
VALUES (1, 1, '2020-01-24 10:14:48.284621+00', 'Me ha encantado, la voy a añadir a mis favoritos. La recomiendo.');

INSERT INTO perfil_comenta_titulo (idPerfil, idTitulo, fecha, comentario)
VALUES (3, 1, '2020-01-24 11:17:59.32517+00', 'Me he reido bastante. Will Smith hace un gran papel.');

COMMIT;


-- -----------------------------------------------------
-- Datos tabla favoritos
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO favoritos (idFavoritos, idTitulo) VALUES (1, 1);
INSERT INTO favoritos (idFavoritos, idTitulo) VALUES (1, 2);
INSERT INTO favoritos (idFavoritos, idTitulo) VALUES (1, 3);
INSERT INTO favoritos (idFavoritos, idTitulo) VALUES (2, 3);
INSERT INTO favoritos (idFavoritos, idTitulo) VALUES (3, 1);
INSERT INTO favoritos (idFavoritos, idTitulo) VALUES (4, 2);

COMMIT;


-- -----------------------------------------------------
-- Datos tabla pendientes
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO pendientes (idPendientes, idTitulo) VALUES (1, 2);
INSERT INTO pendientes (idPendientes, idTitulo) VALUES (2, 3);
INSERT INTO pendientes (idPendientes, idTitulo) VALUES (3, 3);
INSERT INTO pendientes (idPendientes, idTitulo) VALUES (4, 1);


COMMIT;


-- -----------------------------------------------------
-- Datos tabla titulo_serie
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO titulo_serie (idTitulo, capitulo, temporada, idSerie) VALUES (3, 1, 3, 1);

COMMIT;


-- -----------------------------------------------------
-- Datos tabla idioma
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO idioma (nombre) VALUES ('Español');
INSERT INTO idioma (nombre) VALUES ('English');

COMMIT;


-- -----------------------------------------------------
-- Datos tabla subtitulo
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO subtitulo (idTitulo, idIdioma) VALUES (1,1);
INSERT INTO subtitulo (idTitulo, idIdioma) VALUES (1,2);
INSERT INTO subtitulo (idTitulo, idIdioma) VALUES (2,1);
INSERT INTO subtitulo (idTitulo, idIdioma) VALUES (2,2);
INSERT INTO subtitulo (idTitulo, idIdioma) VALUES (3,1);

COMMIT;


-- -----------------------------------------------------
-- Datos tabla titulo_idioma
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO titulo_idioma (idTitulo, idIdioma) VALUES (1,1);
INSERT INTO titulo_idioma (idTitulo, idIdioma) VALUES (2,1);
INSERT INTO titulo_idioma (idTitulo, idIdioma) VALUES (2,2);
INSERT INTO titulo_idioma (idTitulo, idIdioma) VALUES (3,1);
INSERT INTO titulo_idioma (idTitulo, idIdioma) VALUES (3,2);

COMMIT;
