# Administracion y Diseño de Bases de Datos


En este repositorio se subiran todas las practicas que se realizaran a lo largo del curso.

## Presentación Supuesto Proyecto de Bases de Datos

[Practica 1-Supesto Proyecto de Bases de Datos](https://github.com/Zanuro/BDD/blob/master/requisitos.md)

## Instalación y prueba de postgresql

[Practica 2-Instalación y prueba de postgresql](https://github.com/Zanuro/BDD/blob/master/Practica%20Instalación%20y%20prueba%20de%20postgresql.txt)

## Requisitos que debe cumplir esta Base de Datos

## Practica 3-Modelo Conceptual

[Analisis de los requisitos de la BDD de la empresa de alquileres](https://github.com/Zanuro/BDD/blob/master/Alquiler_Inmuebles.png)


[Analisis de los requisitos de la BDD del Servicio de Deportes de la ULL](https://github.com/Zanuro/BDD/blob/master/Copia-de-Deportes.png)

## Practica 4-Diseño Viveros
[Modelo E/R de la base de datos de la empresa de viveros.](https://github.com/Zanuro/BDD/blob/master/viveros.png)

## Practica 5-Club de Baile
[Modelo E/R de la base de datos del Club De Baile.](https://github.com/Zanuro/BDD/blob/master/ClubdeBaile.png)

## Practica 6-Viveros(Diagrama + Implementacion en Postgresql)
[Diagrama del Modelo E/R de la base de datos de Viveros.(formato especifico para el workbench de SQL](https://github.com/Zanuro/BDD/blob/master/eer_viveros_ruyman.mwb)

[Script que permite la creacion e insercion de los datos en la Base De Datos](https://github.com/Zanuro/BDD/blob/master/viveros.sql)

[Imagen del Diagrama EER de la base de datos de Viveros.](https://github.com/Zanuro/BDD/blob/master/workbench_viveros.png)
###### Para cargar los datos es necesario crear la base de datos dentro de postgre:
###### CREATE DATABASE Viveros;
###### Conectarnos a esa Base De Datos: \c Viveros;
###### Cargar el script 'viveros.sql': \i 'path/viveros.sql';

## Practica8-Triggers base de datos Viveros y Farmacia.

[Script base de datos Viveros](https://github.com/Zanuro/BDD/blob/master/Viveros/viveros-trigger-vlad_mod_debug.sql)

[Script base de datos Farmacia](https://github.com/Zanuro/BDD/blob/master/Farmacia/farmacia_datos_y_trigger.sql)

[Imagen del funcionamiento del trigger modify_stock() en Viveros](https://github.com/Zanuro/BDD/blob/master/Viveros/viveros_trigger_vlad.jpg)

[Imagen del funcionamiento del trigger actualizar_compra() en Farmacia](https://github.com/Zanuro/BDD/blob/master/Farmacia/farmacia_trigger.jpg)


## Practica9 - Proyectos Arquitectónicos

[Script base de datos Proyectos Arquitectónicos (PostgreSQL)](https://github.com/Zanuro/BDD/blob/master/ProyectoArquitectonico/proyectos.sql)

[Script en SQL2003 (sin datos ni triggers)](https://github.com/Zanuro/BDD/blob/master/ProyectoArquitectonico/proyectos_sql_2003.sql)

[Imagen del modelo de clases UML de la BD Proyectos Arquitectónicos](https://github.com/Zanuro/BDD/blob/master/ProyectoArquitectonico/esquema.png)

# Proyecto OAN (Video-streaming)



## Asignatura: Administracion y Diseño de Bases de Datos

## Autores:
- Diego Machín Guardia
- Ruymán Rodríguez Martín
- Vlad Alexandru Comanescu

***


#### Información del proyecto:

- [Proyecto Bases de Datos](https://github.com/Zanuro/BDD/blob/master/OAN/Proyecto%20de%20dise%C3%B1o%20de%20una.docx)

- [Definicion de la Base de datos](https://github.com/Zanuro/BDD/blob/master/OAN/Seminario1_Proyecto.docx)


#### Diagramas de los modelos de la base de datos:

- [Modelo Conceptual ER](https://github.com/Zanuro/BDD/blob/master/OAN/E-R-OAN.png)

- [Modelo Logico-Relacional](https://github.com/Zanuro/BDD/blob/master/OAN/OAN_logico_relacional.png)

- [Modelo Logico Objeto-Relacional UML]()


#### Generación de la base de datos:

- [Script SQL de generación de las tablas](https://github.com/Zanuro/BDD/blob/master/OAN/Script/OAN.sql)

- [Script SQL de generación de los asertos y disparadores](https://github.com/Zanuro/BDD/blob/master/OAN/Script/OAN_triggers.sql)


#### Carga de datos:

- [Script SQL con la carga de datos](https://github.com/Zanuro/BDD/blob/master/OAN/Script/OAN_datos.sql)


#### Pruebas:

- [Script SQL con pruebas de inserción, actualización, borrado y comprobación de integridad referencial](https://github.com/Zanuro/BDD/blob/master/OAN/Script/OAN_pruebas.sql)

- [Script SQL con pruebas del funcionamiento de asertos y disparadores](https://github.com/Zanuro/BDD/blob/master/OAN/Script/OAN_pruebas_triggers.sql)

- [Resultado de las pruebas]()


##### Documentos de entregas realizadas: 

[ELABORACIÓN DEL MODELO CONCEPTUAL DE DATOS (ASI-6.1)-Modelo E/R Extendido](https://github.com/Zanuro/BDD/blob/master/E_R.pdf)