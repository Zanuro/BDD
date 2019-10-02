# Supuesto Proyecto de Bases de Datos

## Introducción

La realización de la base de datos para el control de la población de los municipios viene determinada por los requisitos aprobados en el Real Decreto 1690/1986, de 11 de julio, por el que se aprueba el Reglamento de Población y Demarcación Territorial de las Entidades Locales.

Una vez estudiado con detenimiento, hemos dividido la información obtenida en 4 grupos.

* División del territorio español
* Restricciones
* Datos a recopilar de cada persona
* Usuarios
* Permisos de los usuarios en la base de datos


## División del territorio español

El territorio español se divide en provincias. Estas provincias están formadas por un conjunto de municipios. Cada municipio debe contar con un ayuntamiento.

Los ayuntamientos serán los encargados de obtener y tratar los datos de todos los vecinos del municipio. También se encargaran de los datos de los españoles que residen en el extranjero y que estén empadronados en dicho ayuntamiento como residentes en el extranjero.

Cada ayuntamiento se encargará de todo lo relacionado con la división de su municipio, es decir, de mantener su callejero actualizado.

## Restricciones

* Toda persona debe estar empadronada
* Cada persona solo puede estar empadronada en un ayuntamiento
* Los menores de edad no emancipados y  los mayores incapacitados deben estar empadronados en el mismo municipio que los padres que tengan su guarda y custodia o, en su defecto, de sus representantes legales, salvo autorización por escrito de éstos para residir en otro municipio.
* La persona debe residir en una dirección del municipio en el que reside.
* Si la persona no tiene un lugar donde residir, para poder ser empadronado debe existir una comunicación de la situación de dicha persona a los servicios sociales competentes.
* Para poder cambiar de lugar de empadronamiento, se debe realizar primero la baja del lugar donde residía antes de asignarle el nuevo ayuntamiento donde reside actualmente. Por tanto, el ayuntamiento de origen le debe dar de baja, para luego el de destino darle de alta en su municipio.

## Datos a recopilar de cada persona

El Reglamento de Población y Demarcación Territorial de las Entidades Locales determina que datos mínimos deben existir en el registro de la población, indicando cuales son obligatorios y cuales opcionales. Existen algunas diferencias entre los datos que se deben indicar entre una persona que reside en España con respecto a los españoles que residen en el extranjero.

A continuación detallamos los datos mínimos necesarios:

#### Datos de los residentes en españa:

| Descripción | Obligatorio |
|--|--|
| Nombre y apellidos | x |
| Sexo  | x |
| Lugar y fecha de nacimiento | x |
| Número de documento nacional de identidad o, tratándose de extranjeros, del documento que lo sustituya | x |
| Certificado o título escolar o académico que posea | x | 
| Domicilio habitual | x |
| Nacionalidad | x |
| Designación de las personas que pueden representar a cada vecino ante la Administración municipal a efectos patronales | |
| Número de teléfono |

#### Datos de los españoles residentes en el extranjero:

|Descripción | Obligatorio |
|--|--|
| Nombre y apellidos | x |
| Sexo | x |
| Lugar y fecha de nacimiento | x |
| Número del documento nacional de identidad, o pasaporte | x |
| Certificado o título escolar o académico que posea | x | 
| Domicilio en el país de residencia | x |
| Municipio de inscripción en España a efectos electorales | x |
| Designación de las personas que pueden representar a cada inscrito ante la Oficina Consular a efectos padronales | |
| Número de teléfono del domicilio en el país de residencia | |
| Domicilio y número de teléfono del municipio de referencia en España | |


Una vez comprobados los datos solicitados, creemos que lo ideal es crear estructuras independientes para cada tipo, debido a las diferencias existentes.

## Usuarios

Los siguientes usuarios son los que, en principio, tendrán acceso a la base de datos según la información del Real Decreto:

 - Administrador de la base de datos
 - Ayuntamientos
 - Instituto Nacional de Estadística
 - Otras Administraciones públicas

## Permisos de los usuarios en la base de datos

* Cada ayuntamiento solo puede acceder a los datos de las personas de su municipio
* Los ayuntamientos son los encargados de la creación, modificación y eliminación de los datos de las personas de su municipio
* El Instituto Nacional de Estadística puede leer los datos de las personas de cualquier municipio
* El Instituto Nacional de Estadística puede leer los datos de los españoles que residen en el extranjero
* Otras Administraciones públicas pueden leer los datos de los españoles que residen en el extranjero
* Los ayuntamientos son los encargados de la creación, modificación y eliminación de los datos de las personas de su municipio
* Todos los usuarios pueden leer los datos de los callejeros de los ayuntamientos
