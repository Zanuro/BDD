-- -----------------------------------------------------
-- Triggers
-- -----------------------------------------------------
\c oan ;

-- -----------------------------------------------------
-- Antes de INSERTAR/MODIFICAR en la TABLA titulo_serie:
-- Comprueba que el título es una serie
-- -----------------------------------------------------
CREATE OR REPLACE FUNCTION comprueba_serie()
RETURNS trigger AS $comprueba_serie$
BEGIN
  -- Comprobar si el título es una serie
  IF NOT EXISTS (SELECT FROM titulo WHERE idTitulo=NEW.idTitulo AND tipo='Serie') THEN
	RAISE EXCEPTION 'Error, El título indicado no es del tipo Serie.';
  END IF;

  RETURN NEW;
END;
$comprueba_serie$ LANGUAGE plpgsql;


CREATE TRIGGER comp_serie
BEFORE INSERT OR UPDATE ON titulo_serie
FOR EACH ROW
EXECUTE PROCEDURE comprueba_serie();


-- -----------------------------------------------------
-- Antes de MODIFICAR en la TABLA titulo_serie:
-- Impide la modificación del tipo serie a otro tipo, si
-- existe una asociación a una serie
-- -----------------------------------------------------
CREATE OR REPLACE FUNCTION comprueba_modificacion_tipo_titulo()
RETURNS trigger AS $comprueba_modificacion_tipo_titulo$
BEGIN
  -- Si se modifica el atributo tipo y anteriormente era Serie
  IF OLD.tipo <> NEW.tipo AND OLD.tipo = 'Serie' THEN
    IF EXISTS (SELECT FROM titulo_serie WHERE idTitulo=OLD.idTitulo) THEN
      RAISE EXCEPTION 'Error, No se puede modificar el tipo del título, porque existen registros en la tabla titulo_serie que dependen de él.';
    END IF;
  END IF;

  RETURN NEW;
END;
$comprueba_modificacion_tipo_titulo$ LANGUAGE plpgsql;


CREATE TRIGGER comp_mod_tipo_titulo
BEFORE UPDATE ON titulo
FOR EACH ROW
EXECUTE PROCEDURE comprueba_modificacion_tipo_titulo();



-- -----------------------------------------------------
-- Antes de INSERTAR/MODIFICAR en la TABLA perfil_visualiza_titulo:
-- Marca, si es necesario, el título como visualizado
-- -----------------------------------------------------
CREATE OR REPLACE FUNCTION marcar_titulo_visto()
RETURNS trigger AS $marcar_titulo_visto$
DECLARE
  margen CONSTANT INT := 10; -- Margen en minutos, para marcar titulo como visto
  total INT;
BEGIN
  SELECT duracion INTO total
  FROM titulo
  WHERE idTitulo=NEW.idTitulo;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Error, no existe el titulo con id %.', NEW.idTitulo;
  END IF;

  total := (total - margen) * 60; -- Restamos margen y pasamos a segundos

  IF NEW.momento_actual >= total THEN
    -- Marcamos como visto
    NEW.visto = TRUE;
  ELSE
    NEW.visto = FALSE;
  END IF;

  RETURN NEW;
END;
$marcar_titulo_visto$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_marcar_titulo_visto
BEFORE INSERT OR UPDATE ON perfil_visualiza_titulo
FOR EACH ROW
EXECUTE PROCEDURE marcar_titulo_visto();



-- -----------------------------------------------------
-- Antes de INSERTAR en la TABLA perfil_comenta_titulo:
-- Comprueba si el perfil ha visto el título a comentar, si no lo ha visto, cancela
-- -----------------------------------------------------
CREATE OR REPLACE FUNCTION comentar_titulo()
RETURNS trigger AS $comentar_titulo$
DECLARE
  visualizado BOOLEAN;
BEGIN

  SELECT visto INTO visualizado
  FROM perfil_visualiza_titulo
  WHERE idTitulo=NEW.idTitulo AND idPerfil=NEW.idPerfil;
  IF NOT FOUND THEN
    visualizado := FALSE;
  END IF;

  IF NOT visualizado THEN
    RAISE EXCEPTION 'Error, No puedes comentar un título que no has visto.';
  END IF;

  RETURN NEW;
END;
$comentar_titulo$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_comentar_titulo
BEFORE INSERT ON perfil_comenta_titulo
FOR EACH ROW
EXECUTE PROCEDURE comentar_titulo();


-- -----------------------------------------------------
-- Antes de INSERTAR/ACTUALIZAR en la TABLA perfil_perfil:
-- Impide la inserción de perfiles amigos de si mismo
-- -----------------------------------------------------
CREATE OR REPLACE FUNCTION comprobar_amigo()
RETURNS trigger AS $comprobar_amigo$
BEGIN

  IF NEW.idPerfil = NEW.idPerfilAmigo THEN
    RAISE EXCEPTION 'Error, Un perfil no puede ser amigo de si mismo.';
  END IF;

  RETURN NEW;
END;
$comprobar_amigo$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_comprobar_amigo
BEFORE INSERT OR UPDATE ON perfil_perfil
FOR EACH ROW
EXECUTE PROCEDURE comprobar_amigo();


-- -----------------------------------------------------
-- Antes de INSERTAR/ACTUALIZAR en la TABLA perfil:
-- Impide la inserción un perfil si se pasa del límite de perfiles permitidos
-- PREMIUM = 4 ; BASICA = 1 ; CONTENIDO = 4 ;
-- -----------------------------------------------------
CREATE OR REPLACE FUNCTION comprobar_numero_perfiles()
RETURNS trigger AS $comprobar_numero_perfiles$
DECLARE
  t_suscripcion VARCHAR(15);                       -- Tipo de suscripcion
  t_premium CONSTANT VARCHAR(15) := 'Premium';     -- Tipo Premium
  t_contenido CONSTANT VARCHAR(15) := 'Contenido'; -- Max. perfiles suscripcion Contenido
  t_basica CONSTANT VARCHAR(15) := 'Basica';       -- Max. perfiles suscripcion Basica
  premium CONSTANT INT := 4;            -- Max. perfiles suscripcion Premium
  contenido CONSTANT INT := 4;          -- Max. perfiles suscripcion Contenido
  basica CONSTANT INT := 1;             -- Max. perfiles suscripcion Basica
  num_perfiles INT;         -- Total de perfiles
BEGIN
  -- Comprobar si el usuario tiene una suscripción y, si es asi, obtener el tipo
  SELECT tipo_suscripcion INTO t_suscripcion
  FROM suscripcion
  WHERE email=NEW.email AND fecha_finalizacion >= CURRENT_DATE;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Error, El usuario (%) no tiene una suscripcion activa.', NEW.email;
  END IF;

  -- Obtener numero de perfiles del usuario
  SELECT COUNT(*) INTO num_perfiles
  FROM perfil
  WHERE email=NEW.email;

  num_perfiles := num_perfiles + 1;
  -- Comprobar que no se pasa de la cantidad suscrita
  IF (t_suscripcion = t_premium AND num_perfiles > premium) OR
     (t_suscripcion = t_contenido AND num_perfiles > contenido) OR
     (t_suscripcion = t_basica AND num_perfiles > basica) THEN
    RAISE EXCEPTION 'Error, Se excede del número máximo de perfiles (%) que permite tu suscripcion (%)', num_perfiles-1, t_suscripcion;
  END IF;

  RETURN NEW;
END;
$comprobar_numero_perfiles$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_comprobar_numero_perfiles
BEFORE INSERT OR UPDATE ON perfil
FOR EACH ROW
EXECUTE PROCEDURE comprobar_numero_perfiles();



-- -----------------------------------------------------
-- Antes de INSERTAR/ACTUALIZAR en la TABLA suscripcion:
-- Impide que un usuario tenga mas de 1 suscripcion activa
-- -----------------------------------------------------
CREATE OR REPLACE FUNCTION comprobar_num_suscripciones_activas()
RETURNS trigger AS $comprobar_num_suscripciones_activas$
DECLARE
  num_suscripciones INT;  -- Numero de suscripciones activas
BEGIN
  -- Si estamos trabajando en una suscrpcion que estará activa, comprabamos que no tenemos mas de 1 activa
  IF NEW.fecha_finalizacion >= CURRENT_DATE THEN
    IF (TG_OP = 'UPDATE') THEN
      SELECT COUNT(*) INTO num_suscripciones
      FROM suscripcion
      WHERE email=NEW.email AND fecha_finalizacion >= CURRENT_DATE AND idSuscripcion != OLD.idSuscripcion;
    ELSE
      SELECT COUNT(*) INTO num_suscripciones
      FROM suscripcion
      WHERE email=NEW.email AND fecha_finalizacion >= CURRENT_DATE;
    END IF;

    IF num_suscripciones > 0 THEN
      RAISE EXCEPTION 'Error, Los usuarios solo pueden tener una suscripcion activa.';
    END IF;
  END IF;

  RETURN NEW;
END;
$comprobar_num_suscripciones_activas$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_num_suscripciones_activas
BEFORE INSERT OR UPDATE ON suscripcion
FOR EACH ROW
EXECUTE PROCEDURE comprobar_num_suscripciones_activas();


-- -----------------------------------------------------
-- Antes de INSERTAR/ACTUALIZAR en la TABLA descargas:
-- Impide que un usuario tenga mas descargas del maximo
-- permitido por sus suscripción actual
-- -----------------------------------------------------
CREATE OR REPLACE FUNCTION comprobar_num_descargas()
RETURNS trigger AS $comprobar_num_descargas$
DECLARE
  usuario usuario.email%TYPE; -- email usuario
  num_descargas INT;  -- Numero de descargas activas
  max_descargas INT;  -- Numero maximo de descargas permitidas
BEGIN
  -- Obtenemos el usuario al que pertenece el perfil
  SELECT email INTO usuario
  FROM perfil
  WHERE idPerfil=NEW.idPerfil;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Error al descargar: No existe el usuario asociado al perfil (%).', NEW.idPerfil;
  END IF;

  -- Obtenemos el número max de descargas permitidas
  SELECT num_descargas_max INTO max_descargas
  FROM suscripcion
  WHERE email=usuario AND fecha_finalizacion >= CURRENT_DATE;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Error al descargar: El usuario (%) no tiene una suscripción activa.', usuario;
  END IF;

  -- Obtenemos el número de descargas totales
  SELECT COUNT(*) INTO num_descargas
  FROM descargas
  WHERE idPerfil IN (SELECT idPerfil
		     FROM perfil
		     WHERE email=usuario);

  -- Comprobamos si no supera el maximo de descargas
  IF (TG_OP = 'INSERT') OR OLD.idPerfil <> NEW.idPerfil THEN
    num_descargas := num_descargas + 1;
  END IF;

  IF num_descargas > max_descargas THEN
    RAISE EXCEPTION 'Error al descargar, se sobrepasa el número maximo de descargas permitidas (%) por la suspcripción.', max_descargas;
  END IF;

  RETURN NEW;
END;
$comprobar_num_descargas$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_comprobar_num_descargas
BEFORE INSERT OR UPDATE ON descargas
FOR EACH ROW
EXECUTE PROCEDURE comprobar_num_descargas();


-- -----------------------------------------------------
-- Despues de INSERTAR/ACTUALIZAR/ELIMINAR en la TABLA descargas:
-- Actualiza el número de descargas
-- -----------------------------------------------------
CREATE OR REPLACE FUNCTION actualizar_num_descargas_perfil()
RETURNS trigger AS $actualizar_num_descargas_perfil$
DECLARE
  num_descargas INT;  -- Numero de descargas
BEGIN
  IF TG_OP = 'DELETE' THEN
    -- Obtenemos el número de descargas totales
    SELECT COUNT(*) INTO num_descargas
    FROM descargas
    WHERE idPerfil = OLD.idPerfil;

    -- Actualizamos el numero de descargas totales del perfil
    UPDATE perfil
    SET num_descargas_actuales=num_descargas
    WHERE idPerfil=OLD.idPerfil;

    RETURN OLD;
  END IF;

  -- Obtenemos el número de descargas totales
  SELECT COUNT(*) INTO num_descargas
  FROM descargas
  WHERE idPerfil = NEW.idPerfil;

  -- Actualizamos el numero de descargas totales del perfil
  UPDATE perfil
  SET num_descargas_actuales=num_descargas
  WHERE idPerfil=NEW.idPerfil;

  -- Si se modifica el id del perfil, actualizamos tambien el del otro perfil
  IF TG_OP = 'UPDATE' AND OLD.idPerfil <> NEW.idPerfil THEN
    -- Obtenemos el número de descargas totales
    SELECT COUNT(*) INTO num_descargas
    FROM descargas
    WHERE idPerfil = OLD.idPerfil;

    -- Actualizamos el numero de descargas totales del perfil
    UPDATE perfil
    SET num_descargas_actuales=num_descargas
    WHERE idPerfil=OLD.idPerfil;
  END IF;

  RETURN NEW;
END;
$actualizar_num_descargas_perfil$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_actualizar_num_descargas_perfil
AFTER INSERT OR UPDATE OR DELETE ON descargas
FOR EACH ROW
EXECUTE PROCEDURE actualizar_num_descargas_perfil();



-- -----------------------------------------------------
-- Despues de INSERTAR/MODIFICAR en la TABLA perfil_visualiza_titulo:
-- Si se ha visualizado el titulo y está en descargas, elimina la descarga
-- -----------------------------------------------------
CREATE OR REPLACE FUNCTION eliminar_descarga_titulo_visto()
RETURNS trigger AS $eliminar_descarga_titulo_visto$
DECLARE
  margen CONSTANT INT := 10; -- Margen en minutos, para marcar titulo como visto
  total INT;
BEGIN
  IF NEW.visto THEN
    IF EXISTS (SELECT FROM descargas WHERE idTitulo=NEW.idTitulo AND idPerfil=NEW.idPerfil) THEN
      DELETE FROM descargas WHERE idTitulo=NEW.idTitulo AND idPerfil=NEW.idPerfil;
    END IF;
  END IF;

  RETURN NEW;
END;
$eliminar_descarga_titulo_visto$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_eliminar_descarga_titulo_visto
AFTER INSERT OR UPDATE ON perfil_visualiza_titulo
FOR EACH ROW
EXECUTE PROCEDURE eliminar_descarga_titulo_visto();
