\c oan ;

--
-- Tabla actor
--
\o /dev/null
START TRANSACTION;
\o

\echo ============
\echo TABLA ACTOR:
\echo ============
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO actor (nombre) VALUES ('Actor de prueba');
INSERT INTO actor (nombre) VALUES ('Actor de prueba');
\echo
SELECT * FROM actor;


\echo Actualizamos:
\echo -------------
\echo UPDATE actor
\echo SET nombre='Actor de prueba actualizado'
\echo WHERE nombre='Actor de prueba';
UPDATE actor
SET nombre='Actor de prueba actualizado'
WHERE nombre='Actor de prueba';
\echo
SELECT * FROM actor;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM actor WHERE nombre='Actor de prueba actualizado';
DELETE FROM actor WHERE nombre='Actor de prueba actualizado';
\echo
SELECT * FROM actor;

\echo
\o /dev/null
COMMIT;
\o
\echo

\o /dev/null
START TRANSACTION;
\o
\echo Comprobación de Integridad Referencial:
\echo ---------------------------------------
\echo TABLAS AFECTADAS: actor_titulo
SELECT COUNT(*) AS count_1 FROM actor_titulo WHERE idActor=2 \gset
SELECT COUNT(*) AS count_2 FROM actor_titulo WHERE idActor=10 \gset
\echo     - actor_titulo con idActor = 2: :count_1
\echo     - actor_titulo con idActor = 10: :count_2
\echo
\echo UPDATE actor SET idActor=10 WHERE idActor=2;
UPDATE actor SET idActor=10 WHERE idActor=2;
\echo RESULTADO:
SELECT COUNT(*) AS count_1 FROM actor_titulo WHERE idActor=2 \gset
SELECT COUNT(*) AS count_2 FROM actor_titulo WHERE idActor=10 \gset
\echo     - actor_titulo con idActor = 2: :count_1
\echo     - actor_titulo con idActor = 10: :count_2
\echo
\echo DELETE FROM actor WHERE idActor=10;
DELETE FROM actor WHERE idActor=10;
\echo RESULTADO:
SELECT COUNT(*) AS count_2 FROM actor_titulo WHERE idActor=10 \gset
\echo     - actor_titulo con idActor = 10: :count_2
\o /dev/null
ROLLBACK;
\o
\echo
\echo


--
-- Tabla actor_titulo
--
\o /dev/null
START TRANSACTION;
\o

\echo ===================
\echo TABLA ACTOR_TITULO:
\echo ===================
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO actor_titulo (idActor, idTitulo) VALUES (5, 1);
INSERT INTO actor_titulo (idActor, idTitulo) VALUES (5, 1);
\echo
SELECT * FROM actor_titulo;


\echo Actualizamos:
\echo -------------
\echo UPDATE actor_titulo SET idTitulo=2 WHERE idActor=5 AND idTitulo=1;
UPDATE actor_titulo SET idTitulo=2 WHERE idActor=5 AND idTitulo=1;
\echo
SELECT * FROM actor_titulo;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM actor_titulo WHERE idActor=5 AND idTitulo=2;
DELETE FROM actor_titulo WHERE idActor=5 AND idTitulo=2;
\echo
SELECT * FROM actor_titulo;
\echo
\o /dev/null
COMMIT;
\o
\echo
\echo

--
-- Tabla categoría
--
\o /dev/null
START TRANSACTION;
\o

\echo ================
\echo TABLA CATEGORIA:
\echo ================
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO categoria (nombre, descripcion) VALUES ('cat1', 'categoria de prueba insercion');
INSERT INTO categoria (nombre, descripcion) VALUES ('cat1', 'categoria de prueba insercion');
\echo
SELECT * FROM categoria;


\echo Actualizamos:
\echo -------------
\echo UPDATE categoria
\echo SET nombre='cat1update', descripcion='categoria de prueba actualizacion'
\echo WHERE nombre='cat1';
UPDATE categoria
SET nombre='cat1update', descripcion='categoria de prueba actualizacion'
WHERE nombre='cat1';
\echo
SELECT * FROM categoria;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM categoria WHERE nombre='cat1update';
DELETE FROM categoria WHERE nombre='cat1update';
\echo
SELECT * FROM categoria;
\echo
\o /dev/null
COMMIT;
\o
\echo

\o /dev/null
START TRANSACTION;
\o
\echo Comprobación de Integridad Referencial:
\echo ---------------------------------------
\echo TABLAS AFECTADAS: titulo_categoria
SELECT COUNT(*) AS count_1 FROM titulo_categoria WHERE idCategoria=2 \gset
SELECT COUNT(*) AS count_2 FROM titulo_categoria WHERE idCategoria=10 \gset
\echo     - titulo_categoria con idCategoria = 2: :count_1
\echo     - titulo_categoria con idCategoria = 10: :count_2
\echo
\echo UPDATE categoria SET idCategoria=10 WHERE idCategoria=2;
UPDATE categoria SET idCategoria=10 WHERE idCategoria=2;
\echo RESULTADO:
SELECT COUNT(*) AS count_1 FROM titulo_categoria WHERE idCategoria=2 \gset
SELECT COUNT(*) AS count_2 FROM titulo_categoria WHERE idCategoria=10 \gset
\echo     - titulo_categoria con idCategoria = 2: :count_1
\echo     - titulo_categoria con idCategoria = 10: :count_2
\echo
\echo DELETE FROM categoria WHERE idCategoria=10;
DELETE FROM categoria WHERE idCategoria=10;
\echo RESULTADO:
SELECT COUNT(*) AS count_2 FROM titulo_categoria WHERE idCategoria=10 \gset
\echo     - titulo_categoria con idCategoria = 10: :count_2
\o /dev/null
ROLLBACK;
\o
\echo
\echo

--
-- Tabla descargas
--
\o /dev/null
START TRANSACTION;
\o

\echo ================
\echo TABLA DESCARGAS:
\echo ================
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO descargas (idTitulo, fecha_caducidad, idPerfil) VALUES (1, CURRENT_DATE + 1, 4);
INSERT INTO descargas (idTitulo, fecha_caducidad, idPerfil) VALUES (1, CURRENT_DATE + 1, 4);
\echo
SELECT * FROM descargas;


\echo Actualizamos:
\echo -------------
\echo UPDATE descargas
\echo SET fecha_caducidad=CURRENT_DATE + 10
\echo WHERE idPerfil=4 AND idTitulo=1;
UPDATE descargas
SET fecha_caducidad=CURRENT_DATE + 10
WHERE idPerfil=4 AND idTitulo=1;
\echo
SELECT * FROM descargas;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM descargas WHERE idPerfil=4 AND idTitulo=1;
DELETE FROM descargas WHERE idPerfil=4 AND idTitulo=1;
\echo
SELECT * FROM descargas;
\echo
\o /dev/null
COMMIT;
\o
\echo
\echo

--
-- Tabla empleado
--
\o /dev/null
START TRANSACTION;
\o

\echo ===============
\echo TABLA EMPLEADO:
\echo ===============
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO empleado (nombre) VALUES ('Empleado de prueba');
INSERT INTO empleado (nombre) VALUES ('Empleado de prueba');
\echo
SELECT * FROM empleado;


\echo Actualizamos:
\echo -------------
\echo UPDATE empleado
\echo SET nombre='Empleado de prueba actualizado'
\echo WHERE nombre='Empleado de prueba';
UPDATE empleado
SET nombre='Empleado de prueba actualizado'
WHERE nombre='Empleado de prueba';
\echo
SELECT * FROM empleado;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM empleado WHERE nombre='Empleado de prueba actualizado';
DELETE FROM empleado WHERE nombre='Empleado de prueba actualizado';
\echo
SELECT * FROM empleado;
\echo
\o /dev/null
COMMIT;
\o
\echo

\o /dev/null
START TRANSACTION;
\o
\echo Comprobación de Integridad Referencial:
\echo ---------------------------------------
\echo TABLAS AFECTADAS: reporte_empleado
SELECT COUNT(*) AS count_1 FROM reporte_empleado WHERE idEmpleado=1 \gset
SELECT COUNT(*) AS count_2 FROM reporte_empleado WHERE idEmpleado=10 \gset
\echo     - reporte_empleado con idEmpleado = 1: :count_1
\echo     - reporte_empleado con idEmpleado = 10: :count_2
\echo
\echo UPDATE empleado SET idEmpleado=10 WHERE idEmpleado=1;
UPDATE empleado SET idEmpleado=10 WHERE idEmpleado=1;
\echo RESULTADO:
SELECT COUNT(*) AS count_1 FROM reporte_empleado WHERE idEmpleado=1 \gset
SELECT COUNT(*) AS count_2 FROM reporte_empleado WHERE idEmpleado=10 \gset
\echo     - reporte_empleado con idEmpleado = 1: :count_1
\echo     - reporte_empleado con idEmpleado = 10: :count_2
\echo
\echo DELETE FROM empleado WHERE idEmpleado=10;
DELETE FROM empleado WHERE idEmpleado=10;
\o /dev/null
ROLLBACK;
\o
\echo
\echo

--
-- Tabla factura
--
\o /dev/null
START TRANSACTION;
\o

\echo ===============
\echo TABLA FACTURA:
\echo ===============
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO factura (fecha_factura, importe, idSuscripcion) VALUES (CURRENT_DATE, 18.00, 1);
INSERT INTO factura (fecha_factura, importe, idSuscripcion) VALUES (CURRENT_DATE, 18.00, 1);
\echo
SELECT * FROM factura;


\echo Actualizamos:
\echo -------------
\echo UPDATE factura
\echo SET importe=1000.00
\echo WHERE idSuscripcion=1 AND fecha_factura=CURRENT_DATE;
UPDATE factura
SET importe=1000.00
WHERE idSuscripcion=1 AND fecha_factura=CURRENT_DATE;
\echo
SELECT * FROM factura;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM factura WHERE idSuscripcion=1 AND fecha_factura=CURRENT_DATE AND importe=1000.00;
DELETE FROM factura WHERE idSuscripcion=1 AND fecha_factura=CURRENT_DATE AND importe=1000.00;
\echo
SELECT * FROM factura;
\echo
\o /dev/null
COMMIT;
\o
\echo

\o /dev/null
START TRANSACTION;
\o
\echo Comprobación de Integridad Referencial:
\echo ---------------------------------------
\echo TABLAS AFECTADAS: pago
SELECT COUNT(*) AS count_1 FROM pago WHERE idFactura=1 \gset
SELECT COUNT(*) AS count_2 FROM pago WHERE idFactura=10 \gset
\echo     - pago con idFactura = 1: :count_1
\echo     - pago con idFactura = 10: :count_2
\echo
\echo UPDATE factura SET idFactura=10 WHERE idFactura=1;
UPDATE factura SET idFactura=10 WHERE idFactura=1;
\echo RESULTADO:
SELECT COUNT(*) AS count_1 FROM pago WHERE idFactura=1 \gset
SELECT COUNT(*) AS count_2 FROM pago WHERE idFactura=10 \gset
\echo     - pago con idFactura = 1: :count_1
\echo     - pago con idFactura = 10: :count_2
\echo
\echo DELETE FROM factura WHERE idFactura=10;
DELETE FROM factura WHERE idFactura=10;
\o /dev/null
ROLLBACK;
\o
\echo
\echo

--
-- Tabla favoritos
--
\o /dev/null
START TRANSACTION;
\o

\echo ================
\echo TABLA FAVORITOS:
\echo ================
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO favoritos (idFavoritos, idTitulo) VALUES (4, 3);
INSERT INTO favoritos (idFavoritos, idTitulo) VALUES (4, 3);
\echo
SELECT * FROM favoritos;


\echo Actualizamos:
\echo -------------
\echo UPDATE favoritos
\echo SET idTitulo=1
\echo WHERE idFavoritos=4 AND idTitulo=3;
UPDATE favoritos
SET idTitulo=1
WHERE idFavoritos=4 AND idTitulo=3;
\echo
SELECT * FROM favoritos;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM favoritos WHERE idFavoritos=4 AND idTitulo=1;
DELETE FROM favoritos WHERE idFavoritos=4 AND idTitulo=1;
\echo
SELECT * FROM favoritos;
\echo
\o /dev/null
COMMIT;
\o
\echo
\echo

--
-- Tabla idioma
--
\o /dev/null
START TRANSACTION;
\o

\echo ============
\echo TABLA IDIOMA:
\echo ============
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO idioma (nombre) VALUES ('Idioma de prueba');
INSERT INTO idioma (nombre) VALUES ('Idioma de prueba');
\echo
SELECT * FROM idioma;


\echo Actualizamos:
\echo -------------
\echo UPDATE idioma
\echo SET nombre='Idioma de prueba actualizado'
\echo WHERE nombre='Idioma de prueba';
UPDATE idioma
SET nombre='Idioma de prueba actualizado'
WHERE nombre='Idioma de prueba';
\echo
SELECT * FROM idioma;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM idioma WHERE nombre='Idioma de prueba actualizado';
DELETE FROM idioma WHERE nombre='Idioma de prueba actualizado';
\echo
SELECT * FROM idioma;
\echo
\o /dev/null
COMMIT;
\o
\echo

\o /dev/null
START TRANSACTION;
\o
\echo Comprobación de Integridad Referencial:
\echo ---------------------------------------
\echo TABLAS AFECTADAS: titulo_idioma, subtitulo
SELECT COUNT(*) AS count_1 FROM titulo_idioma WHERE idIdioma=2 \gset
SELECT COUNT(*) AS count_2 FROM titulo_idioma WHERE idIdioma=10 \gset
SELECT COUNT(*) AS count_3 FROM subtitulo WHERE idIdioma=2 \gset
SELECT COUNT(*) AS count_4 FROM subtitulo WHERE idIdioma=10 \gset
\echo     - titulo_idioma con idIdioma = 2: :count_1
\echo     - titulo_idioma con idIdioma = 10: :count_2
\echo     - subtitulo con idIdioma = 2: :count_3
\echo     - subtitulo con idIdioma = 10: :count_4
\echo
\echo UPDATE idioma SET idIdioma=10 WHERE idIdioma=2;
UPDATE idioma SET idIdioma=10 WHERE idIdioma=2;
\echo RESULTADO:
SELECT COUNT(*) AS count_1 FROM titulo_idioma WHERE idIdioma=2 \gset
SELECT COUNT(*) AS count_2 FROM titulo_idioma WHERE idIdioma=10 \gset
SELECT COUNT(*) AS count_3 FROM subtitulo WHERE idIdioma=2 \gset
SELECT COUNT(*) AS count_4 FROM subtitulo WHERE idIdioma=10 \gset
\echo     - titulo_idioma con idIdioma = 2: :count_1
\echo     - titulo_idioma con idIdioma = 10: :count_2
\echo     - subtitulo con idIdioma = 2: :count_3
\echo     - subtitulo con idIdioma = 10: :count_4
\echo
\echo DELETE FROM idioma WHERE idIdioma=10;
DELETE FROM idioma WHERE idIdioma=10;
\echo RESULTADO:
SELECT COUNT(*) AS count_1 FROM titulo_idioma WHERE idIdioma=10 \gset
SELECT COUNT(*) AS count_2 FROM subtitulo WHERE idIdioma=10 \gset
\echo     - titulo_idioma con idIdioma = 10: :count_1
\echo     - subtitulo con idIdioma = 10: :count_2
\o /dev/null
ROLLBACK;
\o
\echo
\echo

--
-- Tabla pago
--
\o /dev/null
START TRANSACTION;
\o

\echo ============
\echo TABLA PAGO:
\echo ============
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO pago (fecha, metodo_pago, num_tarjeta, CVC, idFactura)
\echo VALUES (CURRENT_DATE, 'Tajerta', 'tarjeta de prueba', '111', 3);
INSERT INTO pago (fecha, metodo_pago, num_tarjeta, CVC, idFactura)
VALUES (CURRENT_DATE, 'Tajerta', 'tarjeta de prueba', '111', 3);
\echo
SELECT * FROM pago;


\echo Actualizamos:
\echo -------------
\echo UPDATE pago
\echo SET fecha=CURRENT_DATE-5
\echo WHERE idFactura=3;
UPDATE pago
SET fecha=CURRENT_DATE-5
WHERE idFactura=3;
\echo
SELECT * FROM pago;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM pago WHERE idFactura=3;
DELETE FROM pago WHERE idFactura=3;
\echo
SELECT * FROM pago;
\echo
\o /dev/null
COMMIT;
\o
\echo
\echo

--
-- Tabla pendientes
--
\o /dev/null
START TRANSACTION;
\o

\echo =================
\echo TABLA PENDIENTES:
\echo =================
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO pendientes (idPendientes, idTitulo) VALUES (4, 3);
INSERT INTO pendientes (idPendientes, idTitulo) VALUES (4, 3);
\echo
SELECT * FROM pendientes;


\echo Actualizamos:
\echo -------------
\echo UPDATE pendientes
\echo SET idTitulo=1
\echo WHERE idPendientes=4 AND idTitulo=3;
UPDATE pendientes
SET idTitulo=2
WHERE idPendientes=4 AND idTitulo=3;
\echo
SELECT * FROM pendientes;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM pendientes WHERE idPendientes=4 AND idTitulo=2;
DELETE FROM pendientes WHERE idPendientes=4 AND idTitulo=2;
\echo
SELECT * FROM pendientes;
\echo
\o /dev/null
COMMIT;
\o
\echo

--
-- Tabla perfil
--
\o /dev/null
START TRANSACTION;
\o

\echo =============
\echo TABLA PERFIL:
\echo =============
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO perfil (nombre, email) VALUES ('Prueba', 'antonio.gutierrez1984@gmail.com');
INSERT INTO perfil (nombre, email) VALUES ('Prueba', 'antonio.gutierrez1984@gmail.com');
\echo
SELECT * FROM perfil;


\echo Actualizamos:
\echo -------------
\echo UPDATE perfil
\echo SET nombre='PruebaActualizado'
\echo WHERE nombre='Prueba' AND email='antonio.gutierrez1984@gmail.com';
UPDATE perfil
SET nombre='PruebaActualizado'
WHERE nombre='Prueba' AND email='antonio.gutierrez1984@gmail.com';
\echo
SELECT * FROM perfil;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM perfil WHERE nombre='PruebaActualizado' AND email='antonio.gutierrez1984@gmail.com';
DELETE FROM perfil WHERE nombre='PruebaActualizado' AND email='antonio.gutierrez1984@gmail.com';
\echo
SELECT * FROM perfil;
\echo
\o /dev/null
COMMIT;
\o
\echo

\o /dev/null
START TRANSACTION;
\o
\echo Comprobación de Integridad Referencial (con idPerfil):
\echo ------------------------------------------------------
\echo TABLAS AFECTADAS: descargas, perfil_comenta_titulo, perfil_perfil, perfil_visualiza_titulo, redsocial
SELECT COUNT(*) AS count_1 FROM descargas WHERE idPerfil=1 \gset
SELECT COUNT(*) AS count_2 FROM descargas WHERE idPerfil=10 \gset
SELECT COUNT(*) AS count_3 FROM perfil_comenta_titulo WHERE idPerfil=1 \gset
SELECT COUNT(*) AS count_4 FROM perfil_comenta_titulo WHERE idPerfil=10 \gset
SELECT COUNT(*) AS count_5 FROM perfil_perfil WHERE idPerfil=1 \gset
SELECT COUNT(*) AS count_6 FROM perfil_perfil WHERE idPerfil=10 \gset
SELECT COUNT(*) AS count_7 FROM perfil_visualiza_titulo WHERE idPerfil=1 \gset
SELECT COUNT(*) AS count_8 FROM perfil_visualiza_titulo WHERE idPerfil=10 \gset
SELECT COUNT(*) AS count_9 FROM redsocial WHERE idPerfil=1 \gset
SELECT COUNT(*) AS count_10 FROM redsocial WHERE idPerfil=10 \gset
\echo     - descargas con idPerfil = 1: :count_1
\echo     - descargas con idPerfil = 10: :count_2
\echo     - perfil_comenta_titulo con idPerfil = 1: :count_3
\echo     - perfil_comenta_titulo con idPerfil = 10: :count_4
\echo     - perfil_perfil con idPerfil = 1: :count_5
\echo     - perfil_perfil con idPerfil = 10: :count_6
\echo     - perfil_visualiza_titulo con idPerfil = 1: :count_7
\echo     - perfil_visualiza_titulo con idPerfil = 10: :count_8
\echo     - redsocial con idPerfil = 1: :count_9
\echo     - redsocial con idPerfil = 10: :count_10
\echo
\echo UPDATE perfil SET idPerfil=10 WHERE idPerfil=1;
UPDATE perfil SET idPerfil=10 WHERE idPerfil=1;
\echo RESULTADO:
SELECT COUNT(*) AS count_1 FROM descargas WHERE idPerfil=1 \gset
SELECT COUNT(*) AS count_2 FROM descargas WHERE idPerfil=10 \gset
SELECT COUNT(*) AS count_3 FROM perfil_comenta_titulo WHERE idPerfil=1 \gset
SELECT COUNT(*) AS count_4 FROM perfil_comenta_titulo WHERE idPerfil=10 \gset
SELECT COUNT(*) AS count_5 FROM perfil_perfil WHERE idPerfil=1 \gset
SELECT COUNT(*) AS count_6 FROM perfil_perfil WHERE idPerfil=10 \gset
SELECT COUNT(*) AS count_7 FROM perfil_visualiza_titulo WHERE idPerfil=1 \gset
SELECT COUNT(*) AS count_8 FROM perfil_visualiza_titulo WHERE idPerfil=10 \gset
SELECT COUNT(*) AS count_9 FROM redsocial WHERE idPerfil=1 \gset
SELECT COUNT(*) AS count_10 FROM redsocial WHERE idPerfil=10 \gset
\echo     - descargas con idPerfil = 1: :count_1
\echo     - descargas con idPerfil = 10: :count_2
\echo     - perfil_comenta_titulo con idPerfil = 1: :count_3
\echo     - perfil_comenta_titulo con idPerfil = 10: :count_4
\echo     - perfil_perfil con idPerfil = 1: :count_5
\echo     - perfil_perfil con idPerfil = 10: :count_6
\echo     - perfil_visualiza_titulo con idPerfil = 1: :count_7
\echo     - perfil_visualiza_titulo con idPerfil = 10: :count_8
\echo     - redsocial con idPerfil = 1: :count_9
\echo     - redsocial con idPerfil = 10: :count_10
\echo
\echo DELETE FROM perfil WHERE idPerfil=10;
DELETE FROM perfil WHERE idPerfil=10;
\echo RESULTADO:
SELECT COUNT(*) AS count_1 FROM descargas WHERE idPerfil=10 \gset
SELECT COUNT(*) AS count_2 FROM perfil_comenta_titulo WHERE idPerfil=10 \gset
SELECT COUNT(*) AS count_3 FROM perfil_perfil WHERE idPerfil=10 \gset
SELECT COUNT(*) AS count_4 FROM perfil_visualiza_titulo WHERE idPerfil=10 \gset
SELECT COUNT(*) AS count_5 FROM redsocial WHERE idPerfil=10 \gset
\echo     - descargas con idPerfil = 10: :count_1
\echo     - perfil_comenta_titulo con idPerfil = 10: :count_2
\echo     - perfil_perfil con idPerfil = 10: :count_3
\echo     - perfil_visualiza_titulo con idPerfil = 10: :count_4
\echo     - redsocial con idPerfil = 10: :count_5
\o /dev/null
ROLLBACK;
\o
\echo
\o /dev/null
START TRANSACTION;
\o
\echo Comprobación de Integridad Referencial (con idFavoritos e idPendientes):
\echo ------------------------------------------------------------------------
\echo TABLAS AFECTADAS: favoritos, pendientes
SELECT COUNT(*) AS count_1 FROM favoritos WHERE idFavoritos=1 \gset
SELECT COUNT(*) AS count_2 FROM favoritos WHERE idFavoritos=10 \gset
SELECT COUNT(*) AS count_3 FROM pendientes WHERE idPendientes=1 \gset
SELECT COUNT(*) AS count_4 FROM pendientes WHERE idPendientes=10 \gset
\echo     - favoritos con idFavoritos = 1: :count_1
\echo     - favoritos con idFavoritos = 10: :count_2
\echo     - pendientes con idPendientes = 1: :count_3
\echo     - pendientes con idPendientes = 10: :count_4
\echo
\echo UPDATE perfil SET idFavoritos=10 WHERE idFavoritos=1;
UPDATE perfil SET idFavoritos=10 WHERE idFavoritos=1;
\echo UPDATE perfil SET idPendientes=10 WHERE idPendientes=1;
UPDATE perfil SET idPendientes=10 WHERE idPendientes=1;
\echo RESULTADO:
SELECT COUNT(*) AS count_1 FROM favoritos WHERE idFavoritos=1 \gset
SELECT COUNT(*) AS count_2 FROM favoritos WHERE idFavoritos=10 \gset
SELECT COUNT(*) AS count_3 FROM pendientes WHERE idPendientes=1 \gset
SELECT COUNT(*) AS count_4 FROM pendientes WHERE idPendientes=10 \gset
\echo     - favoritos con idFavoritos = 1: :count_1
\echo     - favoritos con idFavoritos = 10: :count_2
\echo     - pendientes con idPendientes = 1: :count_3
\echo     - pendientes con idPendientes = 10: :count_4
\echo
\echo DELETE FROM perfil WHERE idFavoritos=10;
DELETE FROM perfil WHERE idFavoritos=10;
\echo DELETE FROM perfil WHERE idPendientes=10;
DELETE FROM perfil WHERE idPendientes=10;
\echo RESULTADO:
SELECT COUNT(*) AS count_1 FROM favoritos WHERE idFavoritos=10 \gset
SELECT COUNT(*) AS count_2 FROM pendientes WHERE idPendientes=10 \gset
\echo     - favoritos con idFavoritos = 10: :count_1
\echo     - pendientes con idPendientes = 10: :count_2
\o /dev/null
ROLLBACK;
\o
\echo
\echo


--
-- Tabla perfil_comenta_titulo
--
\o /dev/null
START TRANSACTION;
\o

\echo ============================
\echo TABLA PERFIL_COMENTA_TITULO:
\echo ============================
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO perfil_comenta_titulo (idPerfil, idTitulo, fecha, comentario)
\echo VALUES (3, 1, CURRENT_TIMESTAMP, 'Comentario de prueba.');
INSERT INTO perfil_comenta_titulo (idPerfil, idTitulo, fecha, comentario)
VALUES (3, 1, CURRENT_TIMESTAMP, 'Comentario de prueba.');
\echo
SELECT * FROM perfil_comenta_titulo;


\echo Actualizamos:
\echo -------------
\echo UPDATE perfil_comenta_titulo
\echo SET comentario='Comentario de prueba actualizado.'
\echo WHERE idPerfil=3 AND idTitulo=1 AND comentario='Comentario de prueba.';
UPDATE perfil_comenta_titulo
SET comentario='Comentario de prueba actualizado.'
WHERE idPerfil=3 AND idTitulo=1 AND comentario='Comentario de prueba.';
\echo
SELECT * FROM perfil_comenta_titulo;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM perfil_comenta_titulo WHERE idPerfil=3 AND idTitulo=1 AND comentario='Comentario de prueba actualizado.';
DELETE FROM perfil_comenta_titulo WHERE idPerfil=3 AND idTitulo=1 AND comentario='Comentario de prueba actualizado.';
\echo
SELECT * FROM perfil_comenta_titulo;
\echo
\o /dev/null
COMMIT;
\o
\echo
\echo

--
-- Tabla perfil_perfil
--
\o /dev/null
START TRANSACTION;
\o

\echo ====================
\echo TABLA PERFIL_PERFIL:
\echo ====================
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO perfil_perfil (idPerfil, idPerfilAmigo) VALUES (1, 3);
INSERT INTO perfil_perfil (idPerfil, idPerfilAmigo) VALUES (1, 3);
\echo
SELECT * FROM perfil_perfil;


\echo Actualizamos:
\echo -------------
\echo UPDATE perfil_perfil
\echo SET idPerfil=3, idPerfilAmigo=1
\echo WHERE idPerfil=1 AND idPerfilAmigo=3;
UPDATE perfil_perfil
SET idPerfil=3, idPerfilAmigo=1
WHERE idPerfil=1 AND idPerfilAmigo=3;
\echo
SELECT * FROM perfil_perfil;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM perfil_perfil WHERE idPerfil=3 AND idPerfilAmigo=1;
DELETE FROM perfil_perfil WHERE idPerfil=3 AND idPerfilAmigo=1;
\echo
SELECT * FROM perfil_perfil;
\echo
\o /dev/null
COMMIT;
\o
\echo
\echo

--
-- Tabla perfil_visualiza_titulo
--
\o /dev/null
START TRANSACTION;
\o

\echo ==============================
\echo TABLA PERFIL_VISUALIZA_TITULO:
\echo ==============================
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO perfil_visualiza_titulo (idPerfil, idTitulo, momento_actual)
\echo VALUES (1, 2, 1000);
INSERT INTO perfil_visualiza_titulo (idPerfil, idTitulo, momento_actual)
VALUES (1, 2, 1000);
\echo
SELECT * FROM perfil_visualiza_titulo;


\echo Actualizamos:
\echo -------------
\echo UPDATE perfil_visualiza_titulo
\echo SET momento_actual=2000
\echo WHERE idPerfil=1 AND idTitulo=2;
UPDATE perfil_visualiza_titulo
SET momento_actual=2000
WHERE idPerfil=1 AND idTitulo=2;
\echo
SELECT * FROM perfil_visualiza_titulo;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM perfil_visualiza_titulo WHERE idPerfil=1 AND idTitulo=2;
DELETE FROM perfil_visualiza_titulo WHERE idPerfil=1 AND idTitulo=2;
\echo
SELECT * FROM perfil_visualiza_titulo;
\echo
\o /dev/null
COMMIT;
\o
\echo
\echo

--
-- Tabla redsocial
--
\o /dev/null
START TRANSACTION;
\o

\echo ================
\echo TABLA REDSOCIAL:
\echo ================
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO redsocial (nombre, tipo_red_social, idPerfil)
\echo VALUES ('Prueba', 'Facebook', 3);
INSERT INTO redsocial (nombre, tipo_red_social, idPerfil)
VALUES ('Prueba', 'Facebook', 3);
\echo
SELECT * FROM redsocial;


\echo Actualizamos:
\echo -------------
\echo UPDATE redsocial
\echo SET idPerfil=2
\echo WHERE idPerfil=3 AND tipo_red_social='Facebook';
UPDATE redsocial
SET idPerfil=2
WHERE idPerfil=3 AND tipo_red_social='Facebook';
\echo
SELECT * FROM redsocial;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM redsocial WHERE idPerfil=2 AND tipo_red_social='Facebook';
DELETE FROM redsocial WHERE idPerfil=2 AND tipo_red_social='Facebook';
\echo
SELECT * FROM redsocial;
\echo
\o /dev/null
COMMIT;
\o
\echo
\echo

--
-- Tabla reporte
--
\o /dev/null
START TRANSACTION;
\o

\echo ==============
\echo TABLA REPORTE:
\echo ==============
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO reporte (descripcion, estado, email)
\echo VALUES ('Prueba', 'En Pruebas', 'victoria.md@gmail.com');
INSERT INTO reporte (descripcion, estado, email)
VALUES ('Prueba', 'En Pruebas', 'victoria.md@gmail.com');
\echo
SELECT * FROM reporte;


\echo Actualizamos:
\echo -------------
\echo UPDATE reporte
\echo SET estado='Actualizado'
\echo WHERE email='victoria.md@gmail.com' AND descripcion='Prueba';
UPDATE reporte
SET estado='Actualizado'
WHERE email='victoria.md@gmail.com' AND descripcion='Prueba';
\echo
SELECT * FROM reporte;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM reporte WHERE email='victoria.md@gmail.com' AND descripcion='Prueba';
DELETE FROM reporte WHERE email='victoria.md@gmail.com' AND descripcion='Prueba';
\echo
SELECT * FROM reporte;
\echo
\o /dev/null
COMMIT;
\o
\echo

\o /dev/null
START TRANSACTION;
\o
\echo Comprobación de Integridad Referencial:
\echo ---------------------------------------
\echo TABLAS AFECTADAS: reporte_empleado
SELECT COUNT(*) AS count_1 FROM reporte_empleado WHERE idReporte=1 \gset
SELECT COUNT(*) AS count_2 FROM reporte_empleado WHERE idReporte=10 \gset
\echo     - reporte_empleado con idReporte = 1: :count_1
\echo     - reporte_empleado con idReporte = 10: :count_2
\echo
\echo UPDATE reporte SET idReporte=10 WHERE idReporte=1;
UPDATE reporte SET idReporte=10 WHERE idReporte=1;
\echo RESULTADO:
SELECT COUNT(*) AS count_1 FROM reporte_empleado WHERE idReporte=1 \gset
SELECT COUNT(*) AS count_2 FROM reporte_empleado WHERE idReporte=10 \gset
\echo     - reporte_empleado con idReporte = 1: :count_1
\echo     - reporte_empleado con idReporte = 10: :count_2
\echo
\echo DELETE FROM reporte WHERE idReporte=10;
DELETE FROM reporte WHERE idReporte=10;
\o /dev/null
ROLLBACK;
\o
\echo
\echo

--
-- Tabla reporte_empleado
--
\o /dev/null
START TRANSACTION;
\o

\echo =======================
\echo TABLA REPORTE_EMPLEADO:
\echo =======================
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO reporte_empleado (idEmpleado, idReporte) VALUES (2, 1);
INSERT INTO reporte_empleado (idEmpleado, idReporte) VALUES (2, 1);
\echo
SELECT * FROM reporte_empleado;


\echo Actualizamos:
\echo -------------
\echo UPDATE reporte_empleado SET idReporte=3 WHERE idEmpleado=2 AND idReporte=1;
UPDATE reporte_empleado SET idReporte=3 WHERE idEmpleado=2 AND idReporte=1;
\echo
SELECT * FROM reporte_empleado;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM reporte_empleado WHERE idEmpleado=2 AND idReporte=3;
DELETE FROM reporte_empleado WHERE idEmpleado=2 AND idReporte=3;
\echo
SELECT * FROM reporte_empleado;
\echo
\o /dev/null
COMMIT;
\o
\echo
\echo


--
-- Tabla serie
--
\o /dev/null
START TRANSACTION;
\o

\echo ============
\echo TABLA SERIE:
\echo ============
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO serie (nombre, descripcion) VALUES ('Prueba', 'Realizando pruebas.');
INSERT INTO serie (nombre, descripcion) VALUES ('Prueba', 'Realizando pruebas.');
\echo
SELECT * FROM serie;


\echo Actualizamos:
\echo -------------
\echo UPDATE serie
\echo SET nombre='PruebaActualizada'
\echo WHERE nombre='Prueba';
UPDATE serie
SET nombre='PruebaActualizada'
WHERE nombre='Prueba';
\echo
SELECT * FROM serie;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM serie WHERE nombre='PruebaActualizada';
DELETE FROM serie WHERE nombre='PruebaActualizada';
\echo
SELECT * FROM serie;
\echo
\o /dev/null
COMMIT;
\o
\echo

\o /dev/null
START TRANSACTION;
\o
\echo Comprobación de Integridad Referencial:
\echo ---------------------------------------
\echo TABLAS AFECTADAS: titulo_serie
SELECT COUNT(*) AS count_1 FROM titulo_serie WHERE idSerie=1 \gset
SELECT COUNT(*) AS count_2 FROM titulo_serie WHERE idSerie=10 \gset
\echo     - titulo_serie con idSerie = 1: :count_1
\echo     - titulo_serie con idSerie = 10: :count_2
\echo
\echo UPDATE serie SET idSerie=10 WHERE idSerie=1;
UPDATE serie SET idSerie=10 WHERE idSerie=1;
\echo RESULTADO:
SELECT COUNT(*) AS count_1 FROM titulo_serie WHERE idSerie=1 \gset
SELECT COUNT(*) AS count_2 FROM titulo_serie WHERE idSerie=10 \gset
\echo     - titulo_serie con idSerie = 1: :count_1
\echo     - titulo_serie con idSerie = 10: :count_2
\echo
\echo DELETE FROM serie WHERE idSerie=10;
DELETE FROM serie WHERE idSerie=10;
\o /dev/null
ROLLBACK;
\o
\echo
\echo


--
-- Tabla subtitulo
--
\o /dev/null
START TRANSACTION;
\o

\echo ================
\echo TABLA SUBTITULO:
\echo ================
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO subtitulo (idTitulo, idIdioma) VALUES (3,2);
INSERT INTO subtitulo (idTitulo, idIdioma) VALUES (3,2);
\echo
SELECT * FROM subtitulo;


\echo Actualizamos:
\echo -------------
\echo UPDATE subtitulo SET idTitulo=4 WHERE idTitulo=3 AND idIdioma=2;
UPDATE subtitulo SET idTitulo=4 WHERE idTitulo=3 AND idIdioma=2;
\echo
SELECT * FROM subtitulo;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM subtitulo WHERE idTitulo=4 AND idIdioma=2;
DELETE FROM subtitulo WHERE idTitulo=4 AND idIdioma=2;
\echo
SELECT * FROM subtitulo;
\echo
\o /dev/null
COMMIT;
\o
\echo
\echo

--
-- Tabla suscripcion
--
\o /dev/null
START TRANSACTION;
\o

\echo ==================
\echo TABLA SUSCRIPCION:
\echo ==================
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO suscripcion (fecha_finalizacion, num_descargas_max, tipo_suscripcion, email)
\echo VALUES ('2019-01-01', 100, 'Premium', 'antonio.gutierrez1984@gmail.com');
INSERT INTO suscripcion (fecha_finalizacion, num_descargas_max, tipo_suscripcion, email)
VALUES ('2019-01-01', 100, 'Premium', 'antonio.gutierrez1984@gmail.com');
\echo
SELECT * FROM suscripcion;


\echo Actualizamos:
\echo -------------
\echo UPDATE suscripcion
\echo SET num_descargas_max=50
\echo WHERE email='antonio.gutierrez1984@gmail.com' AND fecha_finalizacion='2019-01-01';
UPDATE suscripcion
SET num_descargas_max=50
WHERE email='antonio.gutierrez1984@gmail.com' AND fecha_finalizacion='2019-01-01';
\echo
SELECT * FROM suscripcion;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM suscripcion WHERE email='antonio.gutierrez1984@gmail.com' AND fecha_finalizacion='2019-01-01';
DELETE FROM suscripcion WHERE email='antonio.gutierrez1984@gmail.com' AND fecha_finalizacion='2019-01-01';
\echo
SELECT * FROM suscripcion;
\echo
\o /dev/null
COMMIT;
\o
\echo

\o /dev/null
START TRANSACTION;
\o
\echo Comprobación de Integridad Referencial:
\echo ---------------------------------------
\echo TABLAS AFECTADAS: factura
SELECT COUNT(*) AS count_1 FROM factura WHERE idSuscripcion=1 \gset
SELECT COUNT(*) AS count_2 FROM factura WHERE idSuscripcion=10 \gset
\echo     - factura con idSuscripcion = 1: :count_1
\echo     - factura con idSuscripcion = 10: :count_2
\echo
\echo UPDATE suscripcion SET idSuscripcion=10 WHERE idSuscripcion=1;
UPDATE suscripcion SET idSuscripcion=10 WHERE idSuscripcion=1;
\echo RESULTADO:
SELECT COUNT(*) AS count_1 FROM factura WHERE idSuscripcion=1 \gset
SELECT COUNT(*) AS count_2 FROM factura WHERE idSuscripcion=10 \gset
\echo     - factura con idSuscripcion = 1: :count_1
\echo     - factura con idSuscripcion = 10: :count_2
\echo
\echo DELETE FROM suscripcion WHERE idSuscripcion=10;
DELETE FROM suscripcion WHERE idSuscripcion=10;
\o /dev/null
ROLLBACK;
\o
\echo
\echo


--
-- Tabla titulo
--
\o /dev/null
START TRANSACTION;
\o

\echo =============
\echo TABLA TITULO:
\echo =============
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO titulo (nombre, año, valoracion, duracion, precio, descripcion, calidad, tipo)
\echo VALUES ('Prueba', 2020, 1.0, 1, 0.00, 'Titulo de prueba', '1080', 'Pelicula');
INSERT INTO titulo (nombre, año, valoracion, duracion, precio, descripcion, calidad, tipo)
VALUES ('Prueba', 2020, 1.0, 1, 0.00, 'Titulo de prueba', '1080', 'Pelicula');
\echo
SELECT * FROM titulo;


\echo Actualizamos:
\echo -------------
\echo UPDATE titulo
\echo SET nombre='Prueba Actualizada'
\echo WHERE nombre='Prueba';
UPDATE titulo
SET nombre='Prueba Actualizada'
WHERE nombre='Prueba';
\echo
SELECT * FROM titulo;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM titulo WHERE nombre='Prueba Actualizada';
DELETE FROM titulo WHERE nombre='Prueba Actualizada';
\echo
SELECT * FROM titulo;
\echo
\o /dev/null
COMMIT;
\o
\echo

\o /dev/null
START TRANSACTION;
\o
\echo Comprobación de Integridad Referencial:
\echo ---------------------------------------
\echo TABLAS AFECTADAS: actor_titulo, descargas, favoritos, pendientes, perfil_comenta_titulo, perfil_visualiza_titulo
\echo '                  subtitulo, titulo_categoria, titulo_idioma, titulo_serie'
SELECT COUNT(*) AS count_1 FROM actor_titulo WHERE idTitulo=3 \gset
SELECT COUNT(*) AS count_2 FROM actor_titulo WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_3 FROM descargas WHERE idTitulo=3 \gset
SELECT COUNT(*) AS count_4 FROM descargas WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_5 FROM favoritos WHERE idTitulo=3 \gset
SELECT COUNT(*) AS count_6 FROM favoritos WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_7 FROM pendientes WHERE idTitulo=3 \gset
SELECT COUNT(*) AS count_8 FROM pendientes WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_9 FROM perfil_comenta_titulo WHERE idTitulo=3 \gset
SELECT COUNT(*) AS count_10 FROM perfil_comenta_titulo WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_11 FROM perfil_visualiza_titulo WHERE idTitulo=3 \gset
SELECT COUNT(*) AS count_12 FROM perfil_visualiza_titulo WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_13 FROM subtitulo WHERE idTitulo=3 \gset
SELECT COUNT(*) AS count_14 FROM subtitulo WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_15 FROM titulo_categoria WHERE idTitulo=3 \gset
SELECT COUNT(*) AS count_16 FROM titulo_categoria WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_17 FROM titulo_idioma WHERE idTitulo=3 \gset
SELECT COUNT(*) AS count_18 FROM titulo_idioma WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_19 FROM titulo_serie WHERE idTitulo=3 \gset
SELECT COUNT(*) AS count_20 FROM titulo_serie WHERE idTitulo=10 \gset
\echo     - actor_titulo con idTitulo = 3: :count_1
\echo     - actor_titulo con idTitulo = 10: :count_2
\echo     - descargas con idTitulo = 3: :count_3
\echo     - descargas con idTitulo = 10: :count_4
\echo     - favoritos con idTitulo = 3: :count_5
\echo     - favoritos con idTitulo = 10: :count_6
\echo     - pendientes con idTitulo = 3: :count_7
\echo     - pendientes con idTitulo = 10: :count_8
\echo     - perfil_comenta_titulo con idTitulo = 3: :count_9
\echo     - perfil_comenta_titulo con idTitulo = 10: :count_10
\echo     - perfil_visualiza_titulo con idTitulo = 3: :count_11
\echo     - perfil_visualiza_titulo con idTitulo = 10: :count_12
\echo     - subtitulo con idTitulo = 3: :count_13
\echo     - subtitulo con idTitulo = 10: :count_14
\echo     - titulo_categoria con idTitulo = 3: :count_15
\echo     - titulo_categoria con idTitulo = 10: :count_16
\echo     - titulo_idioma con idTitulo = 3: :count_17
\echo     - titulo_idioma con idTitulo = 10: :count_18
\echo     - titulo_serie con idTitulo = 3: :count_19
\echo     - titulo_serie con idTitulo = 10: :count_20
\echo
\echo UPDATE titulo SET idTitulo=10 WHERE idTitulo=3;
UPDATE titulo SET idTitulo=10 WHERE idTitulo=3;
\echo RESULTADO:
SELECT COUNT(*) AS count_1 FROM actor_titulo WHERE idTitulo=3 \gset
SELECT COUNT(*) AS count_2 FROM actor_titulo WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_3 FROM descargas WHERE idTitulo=3 \gset
SELECT COUNT(*) AS count_4 FROM descargas WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_5 FROM favoritos WHERE idTitulo=3 \gset
SELECT COUNT(*) AS count_6 FROM favoritos WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_7 FROM pendientes WHERE idTitulo=3 \gset
SELECT COUNT(*) AS count_8 FROM pendientes WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_9 FROM perfil_comenta_titulo WHERE idTitulo=3 \gset
SELECT COUNT(*) AS count_10 FROM perfil_comenta_titulo WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_11 FROM perfil_visualiza_titulo WHERE idTitulo=3 \gset
SELECT COUNT(*) AS count_12 FROM perfil_visualiza_titulo WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_13 FROM subtitulo WHERE idTitulo=3 \gset
SELECT COUNT(*) AS count_14 FROM subtitulo WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_15 FROM titulo_categoria WHERE idTitulo=3 \gset
SELECT COUNT(*) AS count_16 FROM titulo_categoria WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_17 FROM titulo_idioma WHERE idTitulo=3 \gset
SELECT COUNT(*) AS count_18 FROM titulo_idioma WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_19 FROM titulo_serie WHERE idTitulo=3 \gset
SELECT COUNT(*) AS count_20 FROM titulo_serie WHERE idTitulo=10 \gset
\echo     - actor_titulo con idTitulo = 3: :count_1
\echo     - actor_titulo con idTitulo = 10: :count_2
\echo     - descargas con idTitulo = 3: :count_3
\echo     - descargas con idTitulo = 10: :count_4
\echo     - favoritos con idTitulo = 3: :count_5
\echo     - favoritos con idTitulo = 10: :count_6
\echo     - pendientes con idTitulo = 3: :count_7
\echo     - pendientes con idTitulo = 10: :count_8
\echo     - perfil_comenta_titulo con idTitulo = 3: :count_9
\echo     - perfil_comenta_titulo con idTitulo = 10: :count_10
\echo     - perfil_visualiza_titulo con idTitulo = 3: :count_11
\echo     - perfil_visualiza_titulo con idTitulo = 10: :count_12
\echo     - subtitulo con idTitulo = 3: :count_13
\echo     - subtitulo con idTitulo = 10: :count_14
\echo     - titulo_categoria con idTitulo = 3: :count_15
\echo     - titulo_categoria con idTitulo = 10: :count_16
\echo     - titulo_idioma con idTitulo = 3: :count_17
\echo     - titulo_idioma con idTitulo = 10: :count_18
\echo     - titulo_serie con idTitulo = 3: :count_19
\echo     - titulo_serie con idTitulo = 10: :count_20
\echo
\echo DELETE FROM titulo WHERE idTitulo=10;
DELETE FROM titulo WHERE idTitulo=10;
\echo RESULTADO:
SELECT COUNT(*) AS count_1 FROM actor_titulo WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_2 FROM descargas WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_3 FROM favoritos WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_4 FROM pendientes WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_5 FROM perfil_comenta_titulo WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_6 FROM perfil_visualiza_titulo WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_7 FROM subtitulo WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_8 FROM titulo_categoria WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_9 FROM titulo_idioma WHERE idTitulo=10 \gset
SELECT COUNT(*) AS count_10 FROM titulo_serie WHERE idTitulo=10 \gset
\echo     - actor_titulo con idPerfil = 10: :count_1
\echo     - descargas con idPerfil = 10: :count_2
\echo     - favoritos con idPerfil = 10: :count_3
\echo     - pendientes con idPerfil = 10: :count_4
\echo     - perfil_comenta_titulo con idPerfil = 10: :count_5
\echo     - perfil_visualiza_titulo con idPerfil = 10: :count_6
\echo     - subtitulo con idPerfil = 10: :count_7
\echo     - titulo_categoria con idPerfil = 10: :count_8
\echo     - titulo_idioma con idPerfil = 10: :count_9
\echo     - titulo_serie con idPerfil = 10: :count_10
\o /dev/null
ROLLBACK;
\o
\echo
\echo


--
-- Tabla titulo_categoria
--
\o /dev/null
START TRANSACTION;
\o

\echo =======================
\echo TABLA TITULO_CATEGORIA:
\echo =======================
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO titulo_categoria (idCategoria, idTitulo) VALUES (3, 1);
INSERT INTO titulo_categoria (idCategoria, idTitulo) VALUES (3, 1);
\echo
SELECT * FROM titulo_categoria;


\echo Actualizamos:
\echo -------------
\echo UPDATE titulo_categoria SET idCategoria=4 WHERE idCategoria=3 AND idTitulo=1;
UPDATE titulo_categoria SET idCategoria=4 WHERE idCategoria=3 AND idTitulo=1;
\echo
SELECT * FROM titulo_categoria;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM titulo_categoria WHERE idCategoria=4 AND idTitulo=1;
DELETE FROM titulo_categoria WHERE idCategoria=4 AND idTitulo=1;
\echo
SELECT * FROM titulo_categoria;
\echo
\o /dev/null
COMMIT;
\o
\echo
\echo


--
-- Tabla titulo_idioma
--
\o /dev/null
START TRANSACTION;
\o

\echo ====================
\echo TABLA TITULO_IDIOMA:
\echo ====================
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO titulo_idioma (idTitulo, idIdioma) VALUES (1,2);
INSERT INTO titulo_idioma (idTitulo, idIdioma) VALUES (1,2);
\echo
SELECT * FROM titulo_idioma;


\echo Actualizamos:
\echo -------------
\echo UPDATE titulo_idioma SET idTitulo=4 WHERE idTitulo=1 AND idIdioma=2;
UPDATE titulo_idioma SET idTitulo=4 WHERE idTitulo=1 AND idIdioma=2;
\echo
SELECT * FROM titulo_idioma;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM titulo_idioma WHERE idTitulo=4 AND idIdioma=2;
DELETE FROM titulo_idioma WHERE idTitulo=4 AND idIdioma=2;
\echo
SELECT * FROM titulo_idioma;
\echo
\o /dev/null
COMMIT;
\o
\echo
\echo


--
-- Tabla titulo_serie
--
\o /dev/null
START TRANSACTION;
\o

\echo ===================
\echo TABLA TITULO_SERIE:
\echo ===================
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO titulo_serie (idTitulo, capitulo, temporada, idSerie) VALUES (4, 2, 3, 1);
INSERT INTO titulo_serie (idTitulo, capitulo, temporada, idSerie) VALUES (4, 2, 3, 1);
\echo
SELECT * FROM titulo_serie;


\echo Actualizamos:
\echo -------------
\echo UPDATE titulo_serie SET capitulo=10 WHERE idTitulo=4;
UPDATE titulo_serie SET capitulo=10 WHERE idTitulo=4;
\echo
SELECT * FROM titulo_serie;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM titulo_serie WHERE idTitulo=4;
DELETE FROM titulo_serie WHERE idTitulo=4;
\echo
SELECT * FROM titulo_serie;
\echo
\o /dev/null
COMMIT;
\o
\echo
\echo


--
-- Tabla usuario
--
\o /dev/null
START TRANSACTION;
\o

\echo ==============
\echo TABLA USUARIO:
\echo ==============
\echo

\echo Insertamos:
\echo -----------
\echo INSERT INTO usuario (email, calle, numero, codPostal, localidad, provincia, pais, fecha_nacimiento, nombre, apellidos)
\echo VALUES ('pepito@gmail.com', 'Prueba', 1, 00000, 'Prueba', 'Prueba', 'España', '2001-10-10', 'Pepito', 'de Prueba');
INSERT INTO usuario (email, calle, numero, codPostal, localidad, provincia, pais, fecha_nacimiento, nombre, apellidos)
VALUES ('pepito@gmail.com', 'Prueba', 1, 00000, 'Prueba', 'Prueba', 'España', '2001-10-10', 'Pepito', 'de Prueba');
\echo
SELECT * FROM usuario;


\echo Actualizamos:
\echo -------------
\echo UPDATE usuario SET apellidos='Actualizado' WHERE email='pepito@gmail.com';
UPDATE usuario SET apellidos='Actualizado' WHERE email='pepito@gmail.com';
\echo
SELECT * FROM usuario;

\echo Eliminamos:
\echo -----------
\echo DELETE FROM usuario WHERE email='pepito@gmail.com';
DELETE FROM usuario WHERE email='pepito@gmail.com';
\echo
SELECT * FROM usuario;
\echo
\o /dev/null
COMMIT;
\o
\echo

\o /dev/null
START TRANSACTION;
\o
\echo Comprobación de Integridad Referencial:
\echo ---------------------------------------
\echo TABLAS AFECTADAS: reporte, suscripcion, perfil
SELECT COUNT(*) AS count_1 FROM reporte WHERE email='antonio.gutierrez1984@gmail.com' \gset
SELECT COUNT(*) AS count_2 FROM suscripcion WHERE email='antonio.gutierrez1984@gmail.com' \gset
SELECT COUNT(*) AS count_3 FROM perfil WHERE email='antonio.gutierrez1984@gmail.com' \gset
\echo     - reporte con email = "antonio.gutierrez1984@gmail.com": :count_1
\echo     - suscripcion con email = "antonio.gutierrez1984@gmail.com": :count_2
\echo     - perfil con email = "antonio.gutierrez1984@gmail.com": :count_3
\echo
\echo UPDATE usuario SET email='prueba@gmail.com' WHERE email='antonio.gutierrez1984@gmail.com';
UPDATE usuario SET email='prueba@gmail.com' WHERE email='antonio.gutierrez1984@gmail.com';
\echo RESULTADO:
SELECT COUNT(*) AS count_1 FROM reporte WHERE email='antonio.gutierrez1984@gmail.com' \gset
SELECT COUNT(*) AS count_2 FROM reporte WHERE email='prueba@gmail.com' \gset
SELECT COUNT(*) AS count_3 FROM suscripcion WHERE email='antonio.gutierrez1984@gmail.com' \gset
SELECT COUNT(*) AS count_4 FROM suscripcion WHERE email='prueba@gmail.com' \gset
SELECT COUNT(*) AS count_5 FROM perfil WHERE email='antonio.gutierrez1984@gmail.com' \gset
SELECT COUNT(*) AS count_6 FROM perfil WHERE email='prueba@gmail.com' \gset
\echo     - reporte con email = "antonio.gutierrez1984@gmail.com": :count_1
\echo     - reporte con email = "prueba@gmail.com": :count_2
\echo     - suscripcion con email = "antonio.gutierrez1984@gmail.com": :count_3
\echo     - suscripcion con email = "prueba@gmail.com": :count_4
\echo     - perfil con email = "antonio.gutierrez1984@gmail.com": :count_5
\echo     - perfil con email = "prueba@gmail.com": :count_6
\echo
\echo DELETE FROM usuario WHERE email='prueba@gmail.com';
DELETE FROM usuario WHERE email='prueba@gmail.com';
\o /dev/null
ROLLBACK;
START TRANSACTION;
\o
\echo
\echo DELETE FROM usuario WHERE email='marco@gmail.com';              <--- No tiene suscripción
DELETE FROM usuario WHERE email='marco@gmail.com';
\o /dev/null
ROLLBACK;
\o