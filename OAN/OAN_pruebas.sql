/*
PARA EJECUTAR ESTE SCRIPT, ES NECESARIO HABER 
CARGADO EL SCRIPT OAN_DATOS.SQL Y NO HABER
MODIFICADO NINGUN DATO.
*/

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

\o /dev/null
ROLLBACK;
\o

\echo '============================================================================================' 
\echo
\echo