<center> <h1> Reunión inicial </h1></center>

**Contratante**: Juan Manuel Rodríguez Poo

**Objetivo**: Crear una base de datos para realizar el censo poblacional.

Este es el resumen de la reunión con el responsable del ente contratante para la creación de la Base de Datos para el censo poblacional de los municipios españoles. De dicha reunión y de las impresiones captadas se procede a sacar las conclusiones de los elementos necesarios para la implementación de dicho encargo.

Hemos sido contratados para llevar este proyecto de esta Base de Datos por el director principal del Instituto Nacional de Estadística,Juan Manuel Rodríguez Poo,que nos entrega este proyecto para desarrollar una jerarquía simple,eficiente y consiste, que cumplan con los requisitos generales de una base de datos y que permita una interacción rápida y concisa con las aplicaciones desarrolladas para consultar/modificar/actualizar o insertar datos en esta Base de Datos.

Para esta estructura se parte de un conjunto de municipios,en el cual cada uno de ellos debe tener un nombre que lo identifique de manera unívoca, una capitalidad que también se debe identificar de manera unívoca, unos límites territoriales que se deben fijar, provincia, mancomunidad(explicada a lo largo del documento) y número de habitantes que se podrá obtener de la cantidad de personas censadas. Estos son datos que ayudan a llevar un mejor control de la población.

Las mancomunidades llevan una relación de 1 a muchos siendo una estructura compuesta por varios municipios,de una o varias provincias, sin que haya una cierta continuidad territorial. El objetivo principal de esta estructura es que se pueden prestar un servicio conjuntamente para todos sus miembros.
Esta estructura estará reflejada en cada uno de los municipios. Cada mancomunidad tendrá que reflejar, recursos económicos de la misma.

Dentro de la estructura de Municipio destacamos las personas residentes de aquel municipio,también llamados vecinos del padrón Municipal que se podrán identificar por datos que los identifique de forma apropiada tales como: nombre y apellidos, sexo, domicilio, nacionalidad, lugar y fecha de nacimiento,número de documento nacional de identidad o, tratándose de extranjeros, del documento que lo sustituya; certificado o título escolar o académico que posea, así como el estado civil, con el fin de facilitar trámites y servicios municipales. Además se dispondrá de campos opcionales para completar los servicios al vecino que serán los campos de representante administrativo y número de teléfono.
En el caso de que se registre a un menor el campo de representante administrativo contendrá el representante legal del menor, el cual será obligatorio siempre y cuando sea menor.
Estos atributos ayudan a facilitar diferentes trámites/acciones necesarias para los vecinos y se tendrá en cuenta que exista al menos un vecino por municipio y que un vecino no ha de tener dos municipios.

Los datos proporcionados al padrón municipal serán unicos,se respetaran las reglas de integridad y atomicidad dando de baja (quitando) todas aquellas inscripciones duplicadas conservando solo una de ellas. En caso de que haya duplicidades en los datos se procurará quitar aquellos datos desfasados o erróneos. Para la comprobación de duplicidad de datos dentro del mismo municipio se puede comprobar la existencia de dos nombres iguales con apellidos iguales y en el caso de que estén registrados con el mismo tipo de documento y este sea distinto no será una duplicidad mientras que en el caso de que tengan documentos distintos habrá que comprobar que esos documentos no pertenezcan a la misma persona. En el caso de que ambos pertenezcan a la misma persona se procederá a dejar solo el dni.

Los extranjeros residentes solo tendrán los derechos pertinentes a los servicios municipales de los censados, lo que significa que no implica todos los derechos correspondientes a una nacionalidad española.

También se nos ha informado del servicio de estadística que, se  subcontrata a otras empresas para poder llevar un control exhaustivo periódico sobre la “verdadera” situación de empadronamiento. Esto se realiza en diferentes zonas para detectar aquellos casos de personas cuyos datos han quedado obsoletos o en zonas donde ha habido un crecimiento veloz en cuanto a los residentes que lo habitan. Por ello, se guardará en la entrada censo un campo de fecha de modificación de los datos.

Por último, el director nos ha comentado de que estaría bien que tratemos de realizar también una estructura separada para aquellos españoles 	residentes en el extranjero ya que sus datos podrían ser necesarios para diferentes acciones o comunicarse con autoridades competentes del país de residencia para cualquier trámite.

Los datos que acompañan a esta estructura serían parecidos a la estructura del residente de un municipio siendo: nombre y apellidos, sexo, lugar y fecha de nacimiento, número del documento nacional de identidad, o pasaporte, certificado o título escolar o académico que posea, domicilio en el país de residencia, municipio de inscripción en España a efectos electorales, así como estado civil. Estos datos serán obligatorios y únicos. Además se incluirá los datos opcionales de nº de telfono español y extranjero y domicilio en España-

Dado el hecho de que los atributos obligatorios de la estructura del residente municipal y el español residente en el municipio son distintos y dado que los derechos y tributos de cada tipo es distinto no ha sido posible juntar estas dos estructuras.
