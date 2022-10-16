-- -----------------------------------------------------
-- Schema unilever
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS unilever DEFAULT CHARACTER SET utf8 ;
USE unilever ;

-- -----------------------------------------------------
-- Table unilever.turnos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilever.turnos (
  id INT(10) NOT NULL AUTO_INCREMENT,
  operario VARCHAR(80) NOT NULL,
  horario VARCHAR(20) NOT NULL,
  PRIMARY KEY (id));

-- -----------------------------------------------------
-- Table unilever.registro
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilever.registro (
  id INT(10) NOT NULL AUTO_INCREMENT,
  fecha DATE NOT NULL,
  cantidad_solicitada INT(45) NOT NULL,
  cantidad_cumplida INT(45) NOT NULL,
  PRIMARY KEY (id));

-- -----------------------------------------------------
-- Table unilever.lineas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilever.lineas (
  id INT(10) NOT NULL,
  cantidad_maquinas INT(20) NOT NULL,
  cantidad_productos INT(20) NOT NULL,
  tipo_linea VARCHAR(45) NOT NULL,
  turnos INT(10) NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_lineas_turnos_idx (turnos),
  CONSTRAINT fk_lineas_turnos
    FOREIGN KEY (turnos)
    REFERENCES unilever.turnos (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table unilever.maquinas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilever.maquinas (
  id INT(10) NOT NULL AUTO_INCREMENT,
  capacidad_producto INT(45) NOT NULL,
  estado_maquina VARCHAR(45) NOT NULL,
  linea INT(10) NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_maquinas_lineas_idx (linea),
  CONSTRAINT fk_maquinas_lineas
    FOREIGN KEY (linea)
    REFERENCES unilever.lineas (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table unilever.mantenimiento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilever.mantenimiento (
  id INT(10) NOT NULL AUTO_INCREMENT,
  fecha DATETIME NOT NULL,
  duracion INT(20) NOT NULL,
  maquina INT(10) NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_mantenimiento_maquinas_idx (maquina),
  CONSTRAINT fk_mantenimiento_maquinas
    FOREIGN KEY (maquina)
    REFERENCES unilever.maquinas (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table unilever.producto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilever.producto (
  id INT(10) NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  tiempo_produccion INT(30) NOT NULL,
  tiempo_limpieza INT(20) NOT NULL,
  fecha_vencimiento DATE NULL,
  registro INT(10) NOT NULL,
  linea INT(10) NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_producto_registro_idx (registro),
  INDEX fk_producto_lineas_idx (linea),
  CONSTRAINT fk_producto_registro
    FOREIGN KEY (registro)
    REFERENCES unilever.registro (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_producto_lineas
    FOREIGN KEY (linea)
    REFERENCES unilever.lineas (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table unilever.pruebas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilever.pruebas (
  id INT(10) NOT NULL AUTO_INCREMENT,
  concepto_prueba VARCHAR(45) NOT NULL,
  fecha DATETIME NOT NULL,
  estado VARCHAR(45) NOT NULL,
  duracion INT(20) NOT NULL,
  maquina INT(10) NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_pruebas_maquinas_idx (maquina),
  CONSTRAINT fk_pruebas_maquinas
    FOREIGN KEY (maquina)
    REFERENCES unilever.maquinas (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table unilever.materia_prima
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilever.materia_prima (
  id INT(10) NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  cantidad_stock INT(45) NOT NULL,
  fecha_vencimiento DATE NOT NULL,
  PRIMARY KEY (id));

-- -----------------------------------------------------
-- Table unilever.formula
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS unilever.formula (
  producto INT(10) NOT NULL,
  materia_prima INT(10) NOT NULL,
  PRIMARY KEY (producto, materia_prima),
  INDEX fk_producto_materia_prima_idx (materia_prima),
  INDEX fk_materia_prima_producto_idx (producto),
  CONSTRAINT fk_producto_materia_prima
    FOREIGN KEY (producto)
    REFERENCES unilever.producto (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_materia_prima_producto
    FOREIGN KEY (materia_prima)
    REFERENCES unilever.materia_prima (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
