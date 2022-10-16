-- MySQL Workbench Forward Engineering

-- SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
-- SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
-- SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema unilever
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS unilever DEFAULT CHARACTER SET utf8 ;
USE unilever;

-- -----------------------------------------------------
-- Table unilever.mantenimientos_programados
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilever.mantenimientos_programados (
  id_mantenimiento INT(10) NOT NULL AUTO_INCREMENT,
  id_maquina INT(10) NOT NULL,
  fecha_mantenimiento DATE NOT NULL,
  duracion_mantenimiento INT(25) NOT NULL,
  PRIMARY KEY (id_mantenimiento));


-- -----------------------------------------------------
-- Table unilever.linea_produccion
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilever.linea_produccion (
  id_linea INT(10) NOT NULL,
  tipo_linea VARCHAR(45) NOT NULL,
  eficacia INT(35) NOT NULL,
  mantenimientos_programados_id_maquina INT(10) NOT NULL,
  PRIMARY KEY (id_linea),
  INDEX fk_linea_produccion_mantenimientos_programados1_idx (mantenimientos_programados_id_maquina ASC) ,
  CONSTRAINT fk_linea_produccion_mantenimientos_programados1
    FOREIGN KEY (mantenimientos_programados_id_maquina)
    REFERENCES unilever.mantenimientos_programados (id_mantenimiento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table unilever.producto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilever.producto (
  isbn_producto INT(10) NOT NULL,
  nombre_producto VARCHAR(45) NOT NULL,
  tiempo_produccion DATE NOT NULL,
  tiempo_limpieza DATE NOT NULL,
  linea_produccion INT(10) NOT NULL,
  PRIMARY KEY (isbn_producto),
  INDEX fk_producto_linea_produccion1_idx (linea_produccion ASC) ,
  CONSTRAINT fk_producto_linea_produccion1
    FOREIGN KEY (linea_produccion)
    REFERENCES unilever.linea_produccion (id_linea)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table unilever.cantidad_productos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilever.cantidad_productos (
  id_produccion INT(10) NOT NULL AUTO_INCREMENT,
  fecha DATE NOT NULL,
  cantidad_producido INT(40) NOT NULL,
  Isbn_producto INT NOT NULL,
  PRIMARY KEY (id_produccion),
  INDEX fk_cantidad_productos_producto_idx (Isbn_producto ASC) ,
  CONSTRAINT fk_cantidad_productos_producto
    FOREIGN KEY (Isbn_producto)
    REFERENCES unilever.producto (isbn_producto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table unilever.remision
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilever.remision (
  id_pedido INT(10) NOT NULL AUTO_INCREMENT,
  solicitante VARCHAR(45) NOT NULL,
  Direccion_solicitante VARCHAR(45) NOT NULL,
  telefono INT(10) NOT NULL,
  correo VARCHAR(45) NOT NULL,
  cantidad_producto INT(45) NOT NULL,
  valor_unitario_producto DOUBLE NOT NULL,
  fecha_pedido DATE NOT NULL,
  remisioncol VARCHAR(45) NOT NULL,
  producto_isbn_producto INT NOT NULL,
  PRIMARY KEY (id_pedido),
  INDEX fk_remision_producto1_idx (producto_isbn_producto ASC) ,
  CONSTRAINT fk_remision_producto1
    FOREIGN KEY (producto_isbn_producto)
    REFERENCES unilever.producto (isbn_producto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table unilever.distribuidor
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilever.distribuidor (
  id_distribuidor INT(10) NOT NULL AUTO_INCREMENT,
  nombre_distribuidor VARCHAR(45) NOT NULL,
  rut INT(20) NOT NULL,
  fecha_pedido DATE NOT NULL,
  fecha_estimada_entrega DATE NOT NULL,
  distribuidorcol VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_distribuidor));
  select * from unilever.distribuidor;
DROP TABLE unilever.distribuidor;

-- -----------------------------------------------------
-- Table unilever.materia_prima
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilever.materia_prima (
  id_materia INT(10) NOT NULL AUTO_INCREMENT,
  nombre_mateia VARCHAR(45) NOT NULL,
  cantidad_en_stock INT(40) NOT NULL,
  fecha_vencimiento DATE NULL,
  distribuidor_id_distribuidor INT(10) NOT NULL,
  PRIMARY KEY (id_materia),
  INDEX fk_materia_prima_distribuidor1_idx (distribuidor_id_distribuidor ASC) ,
  CONSTRAINT fk_materia_prima_distribuidor1
    FOREIGN KEY (distribuidor_id_distribuidor)
    REFERENCES unilever.distribuidor (id_distribuidor)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
     DROP TABLE unilever.materia_prima;


-- -----------------------------------------------------
-- Table unilever.tipo_materia_prima
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilever.tipo_materia_prima (
  id_producto INT(10) NOT NULL,
  id_materia_prima INT(10) NOT NULL,
  PRIMARY KEY (id_producto, id_materia_prima),
  INDEX fk_producto_has_materia_prima_materia_prima1_idx (id_materia_prima ASC) ,
  INDEX fk_producto_has_materia_prima_producto1_idx (id_producto ASC),
  CONSTRAINT fk_producto_has_materia_prima_producto1
    FOREIGN KEY (id_producto)
    REFERENCES unilever.producto (isbn_producto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_producto_has_materia_prima_materia_prima1
    FOREIGN KEY (id_materia_prima)
    REFERENCES unilever.materia_prima (id_materia)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    DROP TABLE unilever.tipo_materia_prima;



INSERT INTO mantenimientos_programados(id_maquina, fecha_mantenimiento, duracion_mantenimiento) VALUES (2,'2022/01/12',5);
SELECT * FROM mantenimientos_programados;
ALTER TABLE distribuidor DROP COLUMN distribuidorcol;
INSERT INTO distribuidor (nombre_distribuidor, rut, fecha_pedido, fecha_estimada_entrega) values ('Distribuidor1', 123456789, '2022/09/15', '2022/10/15');
select * from distribuidor;




-- SET SQL_MODE=@OLD_SQL_MODE;
-- SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
-- SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
