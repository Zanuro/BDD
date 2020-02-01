/*
PARA EJECUTAR ESTE SCRIPT, ES NECESARIO HABER 
CARGADO EL SCRIPT OAN_DATOS.SQL Y NO HABER
MODIFICADO NINGUN DATO.
*/

\c oan ;

\echo '**************************************************************'
\echo '**   PRUEBAS DE FUNCIONAMIENTO DE LOS TRIGGERS              **'
\echo '**************************************************************'
\echo
\echo

--
-- Impedir que se supere el número máximo de descargas de un usuario
--
\echo
\echo '----------------------------------------------------------------------------'
\echo 'DESCARGAS: Impedir Que Se Supere El Número Máximo De Descargas De Un Usuario'
\echo '----------------------------------------------------------------------------'
\echo
\o /dev/null
START TRANSACTION;
\o
\echo 'El usuario antonio.gutierrez1984@gmail.com ya tiene 2 descargas activas.'
\echo 'Insertaremos una nueva y se debe producir un error, pues su maximo es 2.'
\echo
\echo '-- Insertandolo como su perfil 1:'
\echo '   ------------------------------'
INSERT INTO descargas (idTitulo, fecha_caducidad, idPerfil) VALUES (1, CURRENT_DATE + 1, 1);

\o /dev/null
ROLLBACK;
\o

\o /dev/null
START TRANSACTION;
\o

\echo
\echo '-- Insertandolo como su perfil 2:'
\echo '   ------------------------------'
INSERT INTO descargas (idTitulo, fecha_caducidad, idPerfil) VALUES (1, CURRENT_DATE + 1, 2);
\echo
\echo 'Si se han producido 2 errores, funciona correctamente.'
\echo '=============================================================================='
\echo
\echo
\o /dev/null
ROLLBACK;
\o

--
-- Actualizar el número de descargas activas que tiene un perfil
--
\o /dev/null
START TRANSACTION;
\o

\echo
\echo '----------------------------------------------------------------------------'
\echo ' DESCARGAS: Actualizar El Número De Descargas Activas Que Tiene Un Perfil   '
\echo '----------------------------------------------------------------------------' 
\echo
SELECT num_descargas_actuales AS ndescargas FROM perfil WHERE idperfil=1
\gset
\echo 'INFO  Descargas actuales del perfil con id 1:' :ndescargas
\echo
\echo '-- Eliminamos una de las descargas:'
\echo '   --------------------------------'
SELECT idTitulo AS titulo FROM descargas WHERE idperfil=1 LIMIT 1
\gset
DELETE FROM descargas WHERE idTitulo=:titulo AND idPerfil = 1;
SELECT num_descargas_actuales AS ndescargas FROM perfil WHERE idperfil=1
\gset
\echo 'RESULTADO  Descargas actuales del perfil con id 1:' :ndescargas
\echo
\echo '-- Insertamos una descarga:'
\echo '   ------------------------'
INSERT INTO descargas (idTitulo, fecha_caducidad, idPerfil) VALUES (3, CURRENT_DATE + 1, 1);
SELECT num_descargas_actuales AS ndescargas FROM perfil WHERE idperfil=1
\gset
\echo 'RESULTADO  Descargas actuales del perfil con id 1:' :ndescargas
SELECT num_descargas_actuales AS ndescargas FROM perfil WHERE idperfil=4
\gset
\echo 'INFO  Descargas actuales del perfil con id 4:' :ndescargas
\echo
\echo '-- Actualizamos una de las descargas, cambiandola de perfil:'
\echo '   ---------------------------------------------------------'
SELECT idTitulo AS titulo FROM descargas WHERE idperfil=1 LIMIT 1
\gset
UPDATE descargas SET idPerfil=4 WHERE idTitulo=:titulo AND idPerfil=1;
SELECT num_descargas_actuales AS ndescargas FROM perfil WHERE idperfil=1
\gset
\echo 'RESULTADO  Descargas actuales del perfil con id 1:' :ndescargas
SELECT num_descargas_actuales AS ndescargas FROM perfil WHERE idperfil=4
\gset
\echo 'RESULTADO  Descargas actuales del perfil con id 4:' :ndescargas
\echo

\o /dev/null
ROLLBACK;
\o

\echo '============================================================================' 
\echo
\echo

--
-- PERFIL: Impedir asignar más perfiles de los que permite la suscripción actual del usuario.
--  	   Max. Premium y Contenido: 4.    Básica: 1
--
\o /dev/null
START TRANSACTION;
\o

\echo
\echo '-------------------------------------------------------------------------------------------'
\echo ' PERFIL: Impedir asignar más perfiles de los que permite la suscripción actual del usuario.'
\echo '-------------------------------------------------------------------------------------------' 
\echo
\echo 'INFO  El usuario "antonio.gutierrez1984@gmail.com" tiene una suscripcion PREMIUM'
\echo '      y ya tiene 2 perfiles, su máximo son 4.'
\echo 
\echo '-- Insertamos 2 nuevos perfiles:'
\echo '   ----------------------------'
INSERT INTO perfil (nombre, email) VALUES ('Antonio 2', 'antonio.gutierrez1984@gmail.com');
INSERT INTO perfil (nombre, email) VALUES ('Antonio 3', 'antonio.gutierrez1984@gmail.com');
\echo
\echo '-- Ahora, al intentar insertar otro, nos debe dar Error:'
\echo '   -----------------------------------------------------'
INSERT INTO perfil (nombre, email) VALUES ('Antonio 4', 'antonio.gutierrez1984@gmail.com');

\o /dev/null
ROLLBACK;
\o

\o /dev/null
START TRANSACTION;
\o

\echo
\echo 'INFO  El usuario "julia.almeida@gmail.com" tiene una suscripcion BASICA'
\echo '      y ya tiene 1 perfil, su máximo es 1.'
\echo
\echo '-- Al intentar insertar otro nos debe dar Error':
\echo '   ---------------------------------------------'
INSERT INTO perfil (nombre, email) VALUES ('Julia 2', 'julia.almeida@gmail.com');

\o /dev/null
ROLLBACK;
\o

\echo '============================================================================================' 
\echo
\echo

--
-- PERFIL_COMENTA_TITULO: No se permite comentar un titulo que no se ha visto
--
\o /dev/null
START TRANSACTION;
\o

\echo
\echo '---------------------------------------------------------------------------' 
\echo ' PERFIL_COMENTA_TITULO: No se permite comentar un titulo que no se ha visto'
\echo '---------------------------------------------------------------------------' 
\echo
\echo 'INFO  El perfil 4 no ha visto el título 1, vamos a intentar insertar un comentario'
\echo '      que debe producir un error, pues no la ha visto.'
\echo 
\echo '-- Insertamos el comentario:'
\echo '   -------------------------'
INSERT INTO perfil_comenta_titulo (idPerfil, idTitulo, fecha, comentario)
VALUES (4, 1, CURRENT_TIMESTAMP, 'No me ha gustado nada la película');

\o /dev/null
ROLLBACK;
\o

\echo
\echo

\o /dev/null
START TRANSACTION;
\o

\echo 'INFO  El perfil 1 ha visto el título 1, vamos a intentar insertar un comentario'
\echo '      que debe finalizar correctamente, pues ha visto el titulo.'
\echo 
\echo '-- Insertamos el comentario:'
\echo '   -------------------------'
INSERT INTO perfil_comenta_titulo (idPerfil, idTitulo, fecha, comentario)
VALUES (1, 1, CURRENT_TIMESTAMP, 'Ya la he visto 12 veces, la sigo recomendando');

\echo
\echo 'RESULTADO:'
\echo
SELECT * FROM perfil_comenta_titulo WHERE idPerfil=1 AND idTitulo=1;

\o /dev/null
ROLLBACK;
\o

\echo '============================================================================================' 
\echo
\echo



--
-- PERFIL_PERFIL: No se permite que un perfil sea amigo de si mismo
--
\o /dev/null
START TRANSACTION;
\o

\echo
\echo '---------------------------------------------------------------------------' 
\echo ' PERFIL_PERFIL: No se permite que un perfil sea amigo de si mismo'
\echo '---------------------------------------------------------------------------' 
\echo 
\echo '-- Insertamos el perfil 1 como amigo del perfil 1:'
\echo '   -----------------------------------------------'
INSERT INTO perfil_perfil (idPerfil, idPerfilAmigo) VALUES (1, 1);

\o /dev/null
ROLLBACK;
\o

\echo
\echo

\o /dev/null
START TRANSACTION;
\o

\echo '-- Insertamos el perfil 4 como amigo del perfil 4:'
\echo '   -----------------------------------------------'
INSERT INTO perfil_perfil (idPerfil, idPerfilAmigo) VALUES (4, 4);

\o /dev/null
ROLLBACK;
\o

\echo
\echo

\o /dev/null
START TRANSACTION;
\o

\echo '-- Insertamos el perfil 1 como amigo del perfil 4 (debe realizarse sin problemas):'
\echo '   -------------------------------------------------------------------------------'
INSERT INTO perfil_perfil (idPerfil, idPerfilAmigo) VALUES (1, 4);

\echo
\echo 'RESULTADO:'
\echo
SELECT * FROM perfil_perfil WHERE idPerfil=1 AND idPerfilAmigo=4;

\o /dev/null
ROLLBACK;
\o

\echo '============================================================================================' 
\echo
\echo


--
-- PERFIL_VISUALIZA_TITULO: Si el momento actual coincide aproximadamente con la duración del título, se marca como visto.
--
\o /dev/null
START TRANSACTION;
\o

\echo
\echo '---------------------------------------------------------------------------' 
\echo ' PERFIL_VISUALIZA_TITULO: Si el momento actual coincide aproximadamente con'
\echo '                          la duración del título, se marca como visto.     '
\echo '---------------------------------------------------------------------------' 
\echo 
\echo '-- Insertamos visualizacion de 1000 segundos de perfil 1 en titulo 3:'
\echo '   ------------------------------------------------------------------'
INSERT INTO perfil_visualiza_titulo (idPerfil, idTitulo, momento_actual)
VALUES (1, 3, 1000);
\echo
\echo 'RESULTADO:  Debe aparecer como visto = false'
\echo
SELECT * FROM perfil_visualiza_titulo WHERE idPerfil=1 AND idTitulo=3;

\echo
\echo

\echo '-- Ahora, actualizamos el momento actual a 2650 seg. :'
\echo '   ---------------------------------------------------'

UPDATE perfil_visualiza_titulo SET momento_actual = 2650 WHERE idPerfil=1 AND idTitulo=3;
\echo
\echo 'RESULTADO:  Debe aparecer como visto = true'
\echo
SELECT * FROM perfil_visualiza_titulo WHERE idPerfil=1 AND idTitulo=3;

\o /dev/null
ROLLBACK;
\o

\echo '============================================================================================' 
\echo
\echo


--
-- PERFIL_VISUALIZA_TITULO: Si se marca un título como visto y el usuario lo
--                          tiene en descargas, se elimina.
--
\o /dev/null
START TRANSACTION;
\o

\echo
\echo '-----------------------------------------------------------------------------' 
\echo ' PERFIL_VISUALIZA_TITULO: Si se marca un título como visto y el usuario lo'
\echo '                          tiene en descargas, se elimina.'
\echo '-----------------------------------------------------------------------------' 
\echo 
\echo 'INFO: el perfil 1 tiene descargada el titulo 3, pero no lo ha visto.'
\echo
SELECT * FROM descargas WHERE idPerfil=1 AND idTitulo=3;
\echo
\echo '-- Insertamos visualizacion de 2650 segundos de perfil 1 en titulo 3:'
\echo '   ------------------------------------------------------------------'
INSERT INTO perfil_visualiza_titulo (idPerfil, idTitulo, momento_actual)
VALUES (1, 3, 2650);
\echo
\echo 'RESULTADO:  Debe aparecer como visto = true'
\echo
SELECT * FROM perfil_visualiza_titulo WHERE idPerfil=1 AND idTitulo=3;
\echo
\echo 'RESULTADO:  No debe existir en la tabla descargas'
\echo
SELECT * FROM descargas WHERE idPerfil=1 AND idTitulo=3;

\o /dev/null
ROLLBACK;
\o

\echo '============================================================================================' 
\echo
\echo



--
-- 	SUSCRIPCION: Impedir que un usuario tenga más de 1 suscripción activa en el momento actual.
--     
--
\o /dev/null
START TRANSACTION;
\o

\echo 
\echo '-----------------------------------------------------------------------------' 
\echo '  SUSCRIPCION: Impedir que un usuario tenga más de 1 suscripción activa en el'
\echo '               momento actual. '
\echo '-----------------------------------------------------------------------------' 
\echo 
\echo 'INFO: el usuario antonio.gutierrez1984 tiene una solo suscripcion activa.'
\echo 
SELECT * FROM suscripcion WHERE email='antonio.gutierrez1984@gmail.com' and fecha_finalizacion >= CURRENT_DATE;
\echo
\echo '-- Le anadimos al usuario antonio.gutierrez1984 otra suscripcion:'
\echo '------------------------------------------------------------------'
INSERT INTO suscripcion (idsuscripcion, fecha_finalizacion, num_descargas_max, tipo_suscripcion, email)
VALUES (5, '2020-05-10', 1, 'Basica', 'antonio.gutierrez1984@gmail.com');
\echo
\o /dev/null
ROLLBACK;
\o

\echo
\echo

\echo '============================================================================================' 
\echo
\echo

--
--      TITULO:Impedir la modificación del tipo de un título, si anteriormente era serie y aún sigue asociada a una serie.
--     
--
\o /dev/null
START TRANSACTION;
\o

\echo 
\echo '-----------------------------------------------------------------------------' 
\echo ' -- TITULO: Impedir la modificación del tipo de un título, si anteriormente'
\echo '            era serie y aún sigue asociada a una serie'
\echo '-----------------------------------------------------------------------------' 
\echo 
\echo 'INFO: El titulo Historia de dos ciudades es una serie.'
\echo 
SELECT * FROM titulo WHERE nombre='Historia de dos ciudades' and tipo='Serie';
\echo
\echo '-- Modificamos el tipo del titulo de Serie a Documental'
\echo '-------------------------------------------------------'
UPDATE titulo SET tipo='Documental' WHERE nombre='Historia de dos ciudades' and tipo='Serie';
\echo
\o /dev/null
ROLLBACK;
\o

\echo
\echo

\echo '============================================================================================' 
\echo
\echo

--
--     TITULO_SERIE:Comprobar que el título que se desea asociar a una serie es del tipo serie.
--     
--
\o /dev/null
START TRANSACTION;
\o

\echo 
\echo '-----------------------------------------------------------------------------' 
\echo ' -- TITULO_SERIE: Comprobar que el título que se desea asociar a una serie' 
\echo '                  es del tipo serie'
\echo '-----------------------------------------------------------------------------' 
\echo 
\echo 'INFO: El titulo Bad Boys for Life es del tipo Pelicula.'
\echo 
SELECT * FROM titulo WHERE nombre='Bad Boys for Life' and tipo='Pelicula';
\echo
\echo '-- Introducimos la Pelicula en la tabla TITULO_SERIE'
\echo '----------------------------------------------------'
INSERT INTO titulo_serie (idtitulo, capitulo, temporada, idserie)
VALUES (1, 1, 2, 2);
\echo
\o /dev/null
ROLLBACK;
\o
\echo
\echo

\o /dev/null
START TRANSACTION;
\o

\echo 'INFO: El titulo Historia de dos ciudades es del tipo Serie y se encuentra en la tabla titulo_serie.'
\echo 
SELECT * FROM titulo_serie WHERE idtitulo=3;
\echo
\echo '--Cambiamos a otro titulo'
\echo '------------------------------------------------------------------'
UPDATE titulo_serie SET idtitulo=1 WHERE idserie=1 and idtitulo=3;

\echo
\o /dev/null
ROLLBACK;
\o
\echo
\echo


\echo '============================================================================================' 
\echo
\echo




\echo '**************************************************************'
\echo '**   PRUEBAS DE FUNCIONAMIENTO DE LOS CHECKS                **'
\echo '**************************************************************'
\echo
\echo
--
-- PERFIL: El número de descargas actuales no puede ser menor que cero
--
\o /dev/null
START TRANSACTION;
\o

\echo
\echo '-----------------------------------------------------------------------------' 
\echo ' PERFIL: El número de descargas actuales no puede ser menor que cero'
\echo '-----------------------------------------------------------------------------' 
\echo 
\echo
\echo '-- Actualizamos el perfil 1 con un número de -1 descargas actuales:'
\echo '   ----------------------------------------------------------------'
\echo
\echo 'INFO   Se debe producir un error.'
\echo
UPDATE perfil SET num_descargas_actuales = -1 WHERE idPerfil=1;
\echo
\o /dev/null
ROLLBACK;
\o

\echo '============================================================================================' 
\echo
\echo

--
-- REDSOCIAL: El tipo de red social debe ser alguno de los siguientes
--            valores: Facebook, Twitter
--
\o /dev/null
START TRANSACTION;
\o


\echo
\echo '-----------------------------------------------------------------------------' 
\echo ' REDSOCIAL:  El tipo de red social debe ser alguno de los siguientes'
\echo '             valores: Facebook, Twitter'
\echo '-----------------------------------------------------------------------------' 
\echo 
\echo
\echo '-- Actualizamos la redsocial del perfil 3 con tipo Twitter a tipo Facebook'
\echo '   -----------------------------------------------------------------------'
\echo
\echo 'INFO   Lo debe hace correctamente'
\echo
UPDATE redsocial SET tipo_red_social = 'Facebook' WHERE idPerfil=3;
\echo
\echo 'RESULTADO: '
\echo 
SELECT * FROM redsocial WHERE idPerfil=3;
\echo
\echo
\echo '-- Actualizamos la redsocial del perfil 3 con tipo Facebook a tipo Twitter'
\echo '   -----------------------------------------------------------------------'
\echo
\echo 'INFO   Lo debe hace correctamente'
\echo
UPDATE redsocial SET tipo_red_social = 'Twitter' WHERE idPerfil=3;
\echo
\echo 'RESULTADO: '
\echo 
SELECT * FROM redsocial WHERE idPerfil=3;
\echo
\echo
\echo '-- Actualizamos la redsocial del perfil 3 con tipo Twitter a tipo Tuenti'
\echo '   ---------------------------------------------------------------------'
\echo
\echo 'INFO   Debe producir un error'
\echo
UPDATE redsocial SET tipo_red_social = 'Tuenti' WHERE idPerfil=3;
\echo 
\o /dev/null
ROLLBACK;
\o

\echo '============================================================================================' 
\echo
\echo


--
-- SUSCRIPCION: El número de descargas máximas no puede ser menor que cero
--
\o /dev/null
START TRANSACTION;
\o

\echo
\echo '-----------------------------------------------------------------------------' 
\echo ' SUSCRIPCION: El número de descargas máximas no puede ser menor que cero'
\echo '-----------------------------------------------------------------------------' 
\echo 
\echo
\echo '-- Actualizamos la suscripcion 1 con un número de -1 descargas máximas:'
\echo '   --------------------------------------------------------------------'
\echo
\echo 'INFO   Se debe producir un error.'
\echo
UPDATE suscripcion SET num_descargas_max = -1 WHERE idSuscripcion=1;
\echo
\o /dev/null
ROLLBACK;
\o

\echo '============================================================================================' 
\echo
\echo



--
-- SUSCRIPCION: El tipo de suscripción debe ser alguno de los siguientes
-- valores: Basica, Premium, Contenido
--
\o /dev/null
START TRANSACTION;
\o


\echo
\echo '------------------------------------------------------------------------------------' 
\echo ' SUSCRIPCION:  SUSCRIPCION: El tipo de suscripción debe ser alguno de los siguientes'
\echo '               valores: Basica, Premium, Contenido'
\echo '------------------------------------------------------------------------------------' 
\echo 
\echo
\echo '-- Actualizamos la suscipcion 1 de tipo Premium a tipo Basica'
\echo '   ----------------------------------------------------------'
\echo
\echo 'INFO   Lo debe hace correctamente'
\echo
UPDATE suscripcion SET tipo_suscripcion = 'Basica' WHERE idSuscripcion=1;
\echo
\echo 'RESULTADO: '
\echo 
SELECT * FROM suscripcion WHERE idSuscripcion=1;
\echo
\echo
\echo '-- Actualizamos la suscipcion 1 de tipo Basica a tipo Contenido'
\echo '   ------------------------------------------------------------'
\echo
\echo 'INFO   Lo debe hace correctamente'
\echo
UPDATE suscripcion SET tipo_suscripcion = 'Contenido' WHERE idSuscripcion=1;
\echo
\echo 'RESULTADO: '
\echo 
SELECT * FROM suscripcion WHERE idSuscripcion=1;
\echo
\echo
\echo '-- Actualizamos la suscipcion 1 de tipo Contenido a tipo Premium'
\echo '   -------------------------------------------------------------'
\echo
\echo 'INFO   Lo debe hace correctamente'
\echo
UPDATE suscripcion SET tipo_suscripcion = 'Premium' WHERE idSuscripcion=1;
\echo
\echo 'RESULTADO: '
\echo 
SELECT * FROM suscripcion WHERE idSuscripcion=1;
\echo
\echo
\echo '-- Actualizamos la redsocial del perfil 3 con tipo Twitter a tipo Ninguna'
\echo '   ----------------------------------------------------------------------'
\echo
\echo 'INFO   Debe producir un error'
\echo
UPDATE suscripcion SET tipo_suscripcion = 'Ninguna' WHERE idSuscripcion=1;
\echo 
\o /dev/null
ROLLBACK;
\o

\echo '============================================================================================' 
\echo
\echo



--
-- TITULO: Valoración debe estar entre los valores 0.0 y 10.0 ambos incluidos
--
\o /dev/null
START TRANSACTION;
\o

\echo
\echo '-----------------------------------------------------------------------------' 
\echo ' TITULO: Valoración debe estar entre los valores 0.0 y 10.0 ambos incluidos'
\echo '-----------------------------------------------------------------------------' 
\echo 
\echo
\echo '-- Actualizamos el titulo 1 con un número de -0.1 de valoracion:'
\echo '   -------------------------------------------------------------'
\echo
\echo 'INFO   Se debe producir un error.'
\echo
UPDATE titulo SET valoracion = -0.1 WHERE idTitulo=1;
\echo

\o /dev/null
ROLLBACK;
\o

\o /dev/null
START TRANSACTION;
\o

\echo
\echo '-- Actualizamos el titulo 1 con un número de 10.1 de valoracion:'
\echo '   -------------------------------------------------------------'
\echo
\echo 'INFO   Se debe producir un error.'
\echo
UPDATE titulo SET valoracion = 10.1 WHERE idTitulo=1;
\echo

\o /dev/null
ROLLBACK;
\o

\echo '============================================================================================' 
\echo
\echo


--
-- TITULO: El número de descargas máximas no puede ser menor que cero
--
\o /dev/null
START TRANSACTION;
\o

\echo
\echo '-----------------------------------------------------------------------------' 
\echo ' TITULO: La duración del título no puede ser menor que cero'
\echo '-----------------------------------------------------------------------------' 
\echo 
\echo
\echo '-- Actualizamos el titulo 1 con una duracion de -1 minutos:'
\echo '   --------------------------------------------------------'
\echo
\echo 'INFO   Se debe producir un error.'
\echo
UPDATE titulo SET duracion = -1 WHERE idTitulo=1;
\echo
\o /dev/null
ROLLBACK;
\o

\echo '============================================================================================' 
\echo
\echo