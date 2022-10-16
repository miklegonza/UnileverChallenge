-- TURNOS 
USE unilever;
INSERT INTO turnos(operario, horario) VALUES('Monica Restrepo', 'Diurno');
INSERT INTO turnos(operario, horario) VALUES('Andres Salazar', 'Nocturno');
INSERT INTO turnos(operario, horario) VALUES('Manuel Mojica', 'Tarde');
INSERT INTO turnos(operario, horario) VALUES('Antonio Perez', 'Diurno');

SELECT * FROM turnos;

-- REGISTRO
INSERT INTO registro(fecha,cantidad_solicitada,cantidad_cumplida) VALUES('2022/12/25', 700, 700);
INSERT INTO registro(fecha,cantidad_solicitada,cantidad_cumplida) VALUES('2022/12/25', 700, 700);
INSERT INTO registro(fecha,cantidad_solicitada,cantidad_cumplida) VALUES('2022/12/25', 700, 700);
INSERT INTO registro(fecha,cantidad_solicitada,cantidad_cumplida) VALUES('2022/12/25', 700, 700);
INSERT INTO registro(fecha,cantidad_solicitada,cantidad_cumplida) VALUES('2022/12/25', 700, 700);

SELECT * FROM turnos;

-- LINEAS
INSERT INTO lineas(id,cantidad_maquinas, cantidad_productos, tipo_linea, turnos) VALUES(1,12,700,'Aseo personal',2);
INSERT INTO lineas(id,cantidad_maquinas, cantidad_productos, tipo_linea, turnos) VALUES(2,12,650,'Cuidado facial',3);
INSERT INTO lineas(id,cantidad_maquinas, cantidad_productos, tipo_linea, turnos) VALUES(3,12,900,'Aseo del hogar',2);
INSERT INTO lineas(id,cantidad_maquinas, cantidad_productos, tipo_linea, turnos) VALUES(4,12,200,'Cuidado de la piel',2);
INSERT INTO lineas(id,cantidad_maquinas, cantidad_productos, tipo_linea, turnos) VALUES(5,12,700,'Aseo personal',2);

INSERT INTO producto (id, nombre, tiempo_produccion, tiempo_limpieza, fecha_vencimiento, registro, linea) VALUES
    (1, 'jabon', 20, 20, NOW(), 1,1),
    (2, 'shampoo', 20, 20, NOW(), 1,1),
    (3, 'desodorante', 20, 20, NOW(), 1,1),
    (4, 'maizena', 20, 20, NOW(), 1,1),
    (5, 'te', 20, 20, NOW(), 1,1);.




