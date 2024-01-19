CREATE DATABASE global_tickets;
USE global_tickets;

CREATE TABLE staging_tickets (
    fecha_creacion DATETIME,
    numero_incidente VARCHAR(20),
    descripcion VARCHAR(200),
    servicio VARCHAR(50),
    tipo_servicio VARCHAR(50),
    prioridad VARCHAR(10),
    estado VARCHAR(20),
    torre VARCHAR(100),
    entorno VARCHAR(100),
    estado_cumplimiento_SLA VARCHAR(50),
    duracion_dias DECIMAL(12, 9))
;

CREATE TABLE f_incidencias (
    id_incidencia VARCHAR(20) NOT NULL PRIMARY KEY, -- numero incidencia
	id_servicio INT NOT NULL,
    id_tipo_servicio INT NOT NULL,
    id_prioridad INT NOT NULL,
    id_estado INT NOT NULL,
    id_entorno INT NOT NULL,
    id_estado_cumplimiento_SLA INT NOT NULL,
    fecha_creacion DATE NOT NULL,
    duracion_dias DECIMAL(12, 9))
;

CREATE TABLE d_servicio (
    id_servicio INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre_servicio VARCHAR(50))
;

CREATE TABLE d_tipo_servicio (
    id_tipo_servicio INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre_tipo_servicio VARCHAR(50))
;

CREATE TABLE d_prioridad (
    id_prioridad INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre_prioridad VARCHAR(10))
;

CREATE TABLE d_estado (
    id_estado INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre_estado VARCHAR(20))
;

CREATE TABLE d_entorno (
    id_entorno INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre_entorno VARCHAR(100))
;

CREATE TABLE d_estado_cumplimiento_SLA (
    id_estado_cumplimiento_SLA INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre_estado_cumplimiento_SLA VARCHAR(50))
;

ALTER TABLE f_incidencias
ADD FOREIGN KEY (id_servicio) REFERENCES d_servicio(id_servicio),
ADD FOREIGN KEY (id_tipo_servicio) REFERENCES d_tipo_servicio(id_tipo_servicio),
ADD FOREIGN KEY (id_prioridad) REFERENCES d_prioridad(id_prioridad),
ADD FOREIGN KEY (id_estado) REFERENCES d_estado(id_estado),
ADD FOREIGN KEY (id_entorno) REFERENCES d_entorno(id_entorno)
;