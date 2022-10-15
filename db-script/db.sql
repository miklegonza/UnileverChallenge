-- MySQL Workbench Forward Engineering

-- SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
-- SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
-- SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema unilevel
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS unilevel DEFAULT CHARACTER SET utf8 ;
USE unilevel;

-- -----------------------------------------------------
-- Table unilevel.mantenimientos_programados
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilevel.mantenimientos_programados (
  id_mantenimiento INT(10) NOT NULL AUTO_INCREMENT,
  id_maquina INT(10) NOT NULL,
  fecha_mantenimiento DATE NOT NULL,
  duracion_mantenimiento INT(25) NOT NULL,
  PRIMARY KEY (id_mantenimiento));


-- -----------------------------------------------------
-- Table unilevel.linea_produccion
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilevel.linea_produccion (
  id_linea INT(10) NOT NULL,
  tipo_linea VARCHAR(45) NOT NULL,
  eficacia INT(35) NOT NULL,
  mantenimientos_programados_id_maquina INT(10) NOT NULL,
  PRIMARY KEY (id_linea),
  INDEX fk_linea_produccion_mantenimientos_programados1_idx (mantenimientos_programados_id_maquina ASC) ,
  CONSTRAINT fk_linea_produccion_mantenimientos_programados1
    FOREIGN KEY (mantenimientos_programados_id_maquina)
    REFERENCES unilevel.mantenimientos_programados (id_mantenimiento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table unilevel.producto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilevel.producto (
  isbn_producto INT(10) NOT NULL,
  nombre_producto VARCHAR(45) NOT NULL,
  tiempo_produccion DATE NOT NULL,
  tiempo_limpieza DATE NOT NULL,
  linea_produccion INT(10) NOT NULL,
  PRIMARY KEY (isbn_producto),
  INDEX fk_producto_linea_produccion1_idx (linea_produccion ASC) ,
  CONSTRAINT fk_producto_linea_produccion1
    FOREIGN KEY (linea_produccion)
    REFERENCES unilevel.linea_produccion (id_linea)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table unilevel.cantidad_productos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilevel.cantidad_productos (
  id_produccion INT(10) NOT NULL AUTO_INCREMENT,
  fecha DATE NOT NULL,
  cantidad_producido INT(40) NOT NULL,
  Isbn_producto INT NOT NULL,
  PRIMARY KEY (id_produccion),
  INDEX fk_cantidad_productos_producto_idx (Isbn_producto ASC) ,
  CONSTRAINT fk_cantidad_productos_producto
    FOREIGN KEY (Isbn_producto)
    REFERENCES unilevel.producto (isbn_producto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table unilevel.remision
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilevel.remision (
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
    REFERENCES unilevel.producto (isbn_producto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table unilevel.distribuidor
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilevel.distribuidor (
  id_distribuidor INT(10) NOT NULL AUTO_INCREMENT,
  nombre_distribuidor VARCHAR(45) NOT NULL,
  rut INT(20) NOT NULL,
  fecha_pedido DATE NOT NULL,
  fecha_estimada_entrega DATE NOT NULL,
  distribuidorcol VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_distribuidor));
  select * from unilevel.distribuidor;
DROP TABLE unilevel.distribuidor;

-- -----------------------------------------------------
-- Table unilevel.materia_prima
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilevel.materia_prima (
  id_materia INT(10) NOT NULL AUTO_INCREMENT,
  nombre_mateia VARCHAR(45) NOT NULL,
  cantidad_en_stock INT(40) NOT NULL,
  fecha_vencimiento DATE NULL,
  distribuidor_id_distribuidor INT(10) NOT NULL,
  PRIMARY KEY (id_materia),
  INDEX fk_materia_prima_distribuidor1_idx (distribuidor_id_distribuidor ASC) ,
  CONSTRAINT fk_materia_prima_distribuidor1
    FOREIGN KEY (distribuidor_id_distribuidor)
    REFERENCES unilevel.distribuidor (id_distribuidor)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
     DROP TABLE unilevel.materia_prima;


-- -----------------------------------------------------
-- Table unilevel.tipo_materia_prima
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilevel.tipo_materia_prima (
  id_producto INT(10) NOT NULL,
  id_materia_prima INT(10) NOT NULL,
  PRIMARY KEY (id_producto, id_materia_prima),
  INDEX fk_producto_has_materia_prima_materia_prima1_idx (id_materia_prima ASC) ,
  INDEX fk_producto_has_materia_prima_producto1_idx (id_producto ASC),
  CONSTRAINT fk_producto_has_materia_prima_producto1
    FOREIGN KEY (id_producto)
    REFERENCES unilevel.producto (isbn_producto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_producto_has_materia_prima_materia_prima1
    FOREIGN KEY (id_materia_prima)
    REFERENCES unilevel.materia_prima (id_materia)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    DROP TABLE unilevel.tipo_materia_prima;



INSERT INTO mantenimientos_programados(id_maquina, fecha_mantenimiento, duracion_mantenimiento) VALUES (2,'2022/01/12',5);
SELECT * FROM mantenimientos_programados;
ALTER TABLE distribuidor DROP COLUMN distribuidorcol;
INSERT INTO distribuidor (nombre_distribuidor, rut, fecha_pedido, fecha_estimada_entrega) values ('Distribuidor1', 123456789, '2022/09/15', '2022/10/15');
select * from distribuidor;




-- SET SQL_MODE=@OLD_SQL_MODE;
-- SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
-- SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
