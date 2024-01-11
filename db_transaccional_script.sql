-- Creación de la tabla PAIS
CREATE TABLE PAIS (
    cod_pais SERIAL PRIMARY KEY,
    nb_pais VARCHAR(255) NOT NULL
);

-- Creación de la tabla CIUDAD con la relación a PAIS
CREATE TABLE CIUDAD (
    cod_ciudad SERIAL PRIMARY KEY,
    nb_ciudad VARCHAR(255) NOT NULL,
    cod_pais INTEGER REFERENCES PAIS(cod_pais)
);

-- Creación de la tabla SEDE con la relación a CIUDAD
CREATE TABLE SEDE (
    cod_sede SERIAL PRIMARY KEY,
    nb_sede VARCHAR(255) NOT NULL,
    cod_ciudad INTEGER REFERENCES CIUDAD(cod_ciudad)
);

-- Creación de la tabla TIPO_EVENTO
CREATE TABLE TIPO_EVENTO (
    cod_tipo_evento SERIAL PRIMARY KEY,
    nb_tipo_evento VARCHAR(255) NOT NULL
);

-- Creación de la tabla EVENTO con las relaciones a SEDE y TIPO_EVENTO
CREATE TABLE EVENTO (
    cod_evento SERIAL PRIMARY KEY,
    nb_evento VARCHAR(255) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    descripcion TEXT,
    cod_sede INTEGER REFERENCES SEDE(cod_sede),
    email VARCHAR(255),
    cod_tipo_evento INTEGER REFERENCES TIPO_EVENTO(cod_tipo_evento)
);

-- Creación de la tabla TIPO_STAND
CREATE TABLE TIPO_STAND (
    cod_tipo_stand SERIAL PRIMARY KEY,
    nb_tipo_stand VARCHAR(255) NOT NULL
);

-- Creación de la tabla EVENTO_STAND con las relaciones a EVENTO y TIPO_STAND
CREATE TABLE EVENTO_STAND (
    cod_evento INTEGER REFERENCES EVENTO(cod_evento),
    cod_tipo_stand INTEGER REFERENCES TIPO_STAND(cod_tipo_stand),
    cantidad_estimada INTEGER,
    mts2 INTEGER,
    precio DECIMAL(10,2),
    PRIMARY KEY (cod_evento, cod_tipo_stand)
);

-- Creación de la tabla CATEGORIA
CREATE TABLE CATEGORIA (
    cod_categoria SERIAL PRIMARY KEY,
    nb_categoria VARCHAR(255) NOT NULL
);

-- Creación de la tabla SUBCATEGORIA con la relación a CATEGORIA
CREATE TABLE SUBCATEGORIA (
    cod_sub_categoria SERIAL PRIMARY KEY,
    nb_sub_categoria VARCHAR(255) NOT NULL,
    cod_categoria INTEGER REFERENCES CATEGORIA(cod_categoria)
);

-- Creación de la tabla CLIENTE
CREATE TABLE CLIENTE (
    cod_cliente SERIAL PRIMARY KEY,
    nb_cliente VARCHAR(255) NOT NULL,
    ci_rif VARCHAR(20) NOT NULL,
    telefono VARCHAR(20),
    direccion TEXT,
    email VARCHAR(255)
);

-- Creación de la tabla CONTRATO con las relaciones a EVENTO, TIPO_STAND, CLIENTE y SUBCATEGORIA
CREATE TABLE CONTRATO (
    nro_stand SERIAL PRIMARY KEY,
    cod_evento INTEGER,
    cod_tipo_stand INTEGER,
    fecha_alquiler DATE NOT NULL,
    cod_cliente INTEGER REFERENCES CLIENTE(cod_cliente),
    mts2 INTEGER,
    monto DECIMAL(10,2),
    cod_sub_categoria INTEGER REFERENCES SUBCATEGORIA(cod_sub_categoria),
    FOREIGN KEY (cod_evento, cod_tipo_stand) REFERENCES EVENTO_STAND(cod_evento, cod_tipo_stand)
);

-- Creación de la tabla VISITANTE
CREATE TABLE VISITANTE (
    cod_visitante SERIAL PRIMARY KEY,
    cedula VARCHAR(20) NOT NULL,
    nb_visitante VARCHAR(255) NOT NULL,
    sexo CHAR(1),
    email VARCHAR(255)
);

-- Creación de la tabla LEYENDA_ESTRELLAS
CREATE TABLE LEYENDA_ESTRELLAS (
    cod_leyenda_estrellas SERIAL PRIMARY KEY,
    nb_descripcion VARCHAR(255) NOT NULL
);

-- Creación de la tabla ENTRADA con las relaciones a EVENTO, VISITANTE y LEYENDA_ESTRELLAS
CREATE TABLE ENTRADA (
    nro_entrada SERIAL PRIMARY KEY,
    cod_evento INTEGER REFERENCES EVENTO(cod_evento),
    fecha_entrada DATE NOT NULL,
    hora_entrada TIME NOT NULL,
    cod_visitante INTEGER REFERENCES VISITANTE(cod_visitante),
    recomienda_amigo BOOLEAN,
    calificacion INTEGER,
    cod_leyenda_estrellas INTEGER REFERENCES LEYENDA_ESTRELLAS(cod_leyenda_estrellas)
);
----

-- Inserción de valores en la tabla TIPO_EVENTO
INSERT INTO TIPO_EVENTO (nb_tipo_evento) VALUES
    ('Feria'),
    ('Bazar'),
    ('Exposición');

INSERT INTO CATEGORIA (nb_categoria) VALUES
    ('Comida'),
    ('Ropa y Calzado'),
    ('Deporte');

INSERT INTO SUBCATEGORIA (nb_sub_categoria,cod_categoria) VALUES
    ('Postres y Dulces',1),
    ('Hamburguesas',1),
    ('Ropa para Damas',2),
    ('Ropa para Caballeros',2),
    ('Ropa para niños',2),
    ('Football',3),
    ('Basketball',3);

-- Inserción de valores en la tabla LEYENDA_ESTRELLAS
INSERT INTO LEYENDA_ESTRELLAS (nb_descripcion) VALUES
    ('Malo'),
    ('Regular'),
    ('Bueno'),
    ('Muy Bueno'),
    ('Excelente');

----

-- Inserción de nuevos valores en la tabla TIPO_EVENTO
INSERT INTO TIPO_EVENTO (nb_tipo_evento) VALUES
    ('Conferencia'),
    ('Concierto'),
    ('Seminario'),
    ('Taller'),
    ('Convención'),
    ('Presentación'),
    ('Gala'),
    ('Festival'),
    ('Feria de Empleo'),
    ('Actividad Deportiva'),
    ('Subasta'),
    ('Concurso');

-- Inserción de valores en la tabla TIPO_STAND
INSERT INTO TIPO_STAND (nb_tipo_stand) VALUES
    ('Mínima'),
    ('Estándar'),
    ('Máximo/Ajustable');

-- Inserción de datos en la tabla PAIS
INSERT INTO PAIS (nb_pais) VALUES
    ('Venezuela'),
    ('Estados Unidos'),
    ('España'),
    ('China'),
    ('Brasil');

-- Insertar ciudades para Venezuela
INSERT INTO CIUDAD (nb_ciudad, cod_pais) VALUES
    ('Caracas', 1),
    ('Maracaibo', 1),
    ('Valencia', 1),
    ('Barquisimeto', 1),
    ('Merida', 1);

-- Insertar ciudades para Estados Unidos
INSERT INTO CIUDAD (nb_ciudad, cod_pais) VALUES
    ('Nueva York', 2),
    ('Los Ángeles', 2),
    ('Chicago', 2),
    ('Houston', 2),
    ('Miami', 2);

-- Insertar ciudades para España
INSERT INTO CIUDAD (nb_ciudad, cod_pais) VALUES
    ('Madrid', 3),
    ('Barcelona', 3),
    ('Valencia', 3),
    ('Sevilla', 3),
    ('Zaragoza', 3);

-- Insertar ciudades para China
INSERT INTO CIUDAD (nb_ciudad, cod_pais) VALUES
    ('Pekín', 4),
    ('Shanghái', 4),
    ('Cantón', 4),
    ('Shenzhen', 4),
    ('Wuhan', 4);

-- Insertar ciudades para Brasil
INSERT INTO CIUDAD (nb_ciudad, cod_pais) VALUES
    ('Sao Paulo', 5),
    ('Río de Janeiro', 5),
    ('Brasilia', 5),
    ('Salvador', 5),
    ('Fortaleza', 5);

-- Insertar sedes con prefijo de la ciudad en nb_sede
INSERT INTO SEDE (nb_sede, cod_ciudad) VALUES
    ('Caracas - Sede1', 1),   -- Caracas, Venezuela
    ('Maracaibo - Sede2', 2),   -- Maracaibo, Venezuela
    ('Valencia - Sede3', 3),   -- Valencia, Venezuela
    ('Barquisimeto - Sede4', 4),   -- Barquisimeto, Venezuela
    ('Merida - Sede5', 5),   -- Merida, Venezuela
    ('Nueva York - Sede6', 6),   -- Nueva York, Estados Unidos
    ('Los Ángeles - Sede7', 7),   -- Los Ángeles, Estados Unidos
    ('Chicago - Sede8', 8),   -- Chicago, Estados Unidos
    ('Houston - Sede9', 9),   -- Houston, Estados Unidos
    ('Miami - Sede10', 10), -- Miami, Estados Unidos
    ('Madrid - Sede11', 11), -- Madrid, España
    ('Barcelona - Sede12', 12), -- Barcelona, España
    ('Valencia - Sede13', 13), -- Valencia, España
    ('Sevilla - Sede14', 14), -- Sevilla, España
    ('Zaragoza - Sede15', 15), -- Zaragoza, España
    ('Pekín - Sede16', 16), -- Pekín, China
    ('Shanghái - Sede17', 17), -- Shanghái, China
    ('Cantón - Sede18', 18), -- Cantón, China
    ('Shenzhen - Sede19', 19), -- Shenzhen, China
    ('Wuhan - Sede20', 20), -- Wuhan, China
    ('Sao Paulo - Sede21', 21), -- Sao Paulo, Brasil
    ('Río de Janeiro - Sede22', 22), -- Río de Janeiro, Brasil
    ('Brasilia - Sede23', 23), -- Brasilia, Brasil
    ('Salvador - Sede24', 24), -- Salvador, Brasil
    ('Fortaleza - Sede25', 25); -- Fortaleza, Brasil

-- Insertar eventos con prefijo de la ciudad, fechas desde 2016 hasta 2024 y descripciones aleatorias
INSERT INTO EVENTO (nb_evento, fecha_inicio, fecha_fin, descripcion, cod_sede, email, cod_tipo_evento) VALUES
    ('Caracas Evento1', '2016-05-15', '2016-05-17', 'Venta especial de tecnología', 1, 'caracas_evento1@example.com', 1),
    ('Maracaibo Evento2', '2017-08-20', '2017-08-22', 'Promoción de moda y accesorios', 2, 'maracaibo_evento2@example.com', 2),
    ('Valencia Evento3', '2018-11-25', '2018-11-27', 'Exposición de arte local', 3, 'valencia_evento3@example.com', 3),
    ('Barquisimeto Evento4', '2019-02-10', '2019-02-12', 'Feria de alimentos gourmet', 4, 'barquisimeto_evento4@example.com', 1),
    ('Merida Evento5', '2020-04-05', '2020-04-07', 'Gran venta de electrónicos', 5, 'merida_evento5@example.com', 2),
    ('Nueva York Evento6', '2021-07-15', '2021-07-17', 'Descuentos exclusivos en moda', 6, 'nueva_york_evento6@example.com', 3),
    ('Los Ángeles Evento7', '2022-09-22', '2022-09-24', 'Exhibición de automóviles', 7, 'los_angeles_evento7@example.com', 1),
    ('Chicago Evento8', '2023-12-01', '2023-12-03', 'Ofertas especiales en electrónicos', 8, 'chicago_evento8@example.com', 2),
    ('Houston Evento9', '2024-02-14', '2024-02-16', 'Feria de decoración del hogar', 9, 'houston_evento9@example.com', 3),
    ('Miami Evento10', '2024-06-30', '2024-07-02', 'Venta de verano en ropa y accesorios', 10, 'miami_evento10@example.com', 1),
    ('Madrid Evento11', '2017-10-12', '2017-10-14', 'Promoción de vinos locales', 11, 'madrid_evento11@example.com', 2),
    ('Barcelona Evento12', '2018-12-18', '2018-12-20', 'Feria de tecnología e innovación', 12, 'barcelona_evento12@example.com', 3),
    ('Valencia Evento13', '2019-03-25', '2019-03-27', 'Exposición de diseño de interiores', 13, 'valencia_evento13@example.com', 1),
    ('Sevilla Evento14', '2020-05-08', '2020-05-10', 'Descuentos en productos de belleza', 14, 'sevilla_evento14@example.com', 2),
    ('Zaragoza Evento15', '2021-08-01', '2021-08-03', 'Gran feria gastronómica', 15, 'zaragoza_evento15@example.com', 3);

-- Insertar datos en la tabla CLIENTE con nombres de clientes reales
INSERT INTO CLIENTE (nb_cliente, ci_rif, telefono, direccion, email) VALUES
    ('Juan Pérez', 'V12345678', '555-1234', 'Calle 123, Ciudad', 'juanperez@example.com'),
    ('María Rodríguez', 'E87654321', '555-5678', 'Avenida XYZ, Pueblo', 'mariarodriguez@example.com'),
    ('Carlos González', 'J987654321', '555-9876', 'Carretera ABC, Villa', 'carlosgonzalez@example.com'),
    ('Laura Fernández', 'G87654321', '555-4321', 'Calle 456, Aldea', 'laurafernandez@example.com'),
    ('Luis Torres', 'V76543210', '555-8765', 'Avenida MNO, Ciudad', 'luistorres@example.com'),
    ('Ana Sánchez', 'E65432109', '555-2345', 'Carretera PQR, Pueblo', 'anasanchez@example.com'),
    ('Javier Méndez', 'J54321098', '555-7890', 'Calle 789, Villa', 'javiermendez@example.com'),
    ('Gabriela Jiménez', 'G43210987', '555-3456', 'Avenida XYZ, Aldea', 'gabrielajimenez@example.com'),
    ('Pedro López', 'V32109876', '555-8901', 'Carretera ABC, Ciudad', 'pedrolopez@example.com'),
    ('Isabel Martínez', 'E21098765', '555-4567', 'Calle 012, Pueblo', 'isabelmartinez@example.com'),
    ('Sergio Rodríguez', 'J10987654', '555-0123', 'Avenida DEF, Villa', 'sergiorodriguez@example.com'),
    ('Marta García', 'G09876543', '555-6789', 'Carretera MNO, Aldea', 'martagarcia@example.com'),
    ('Alejandro Pérez', 'V98765432', '555-2345', 'Calle 345, Ciudad', 'alejandroperez@example.com'),
    ('Natalia Sánchez', 'E87654321', '555-8901', 'Avenida XYZ, Pueblo', 'nataliasanchez@example.com'),
    ('Héctor González', 'J76543210', '555-3456', 'Carretera ABC, Villa', 'hectorgonzalez@example.com'),
    ('Rosa Torres', 'G65432109', '555-0123', 'Calle 678, Aldea', 'rosatorres@example.com'),
    ('Andrés Martínez', 'V54321098', '555-6789', 'Avenida PQR, Ciudad', 'andresmartinez@example.com'),
    ('Carmen López', 'E43210987', '555-2345', 'Carretera DEF, Pueblo', 'carmenlopez@example.com'),
    ('Raúl Sánchez', 'J32109876', '555-8901', 'Calle 901, Villa', 'raulsanchez@example.com'),
    ('Elena García', 'G21098765', '555-3456', 'Avenida XYZ, Aldea', 'elenagarcia@example.com');
    
-- Insertar datos en la tabla EVENTO_STAND para los 15 eventos
INSERT INTO EVENTO_STAND (cod_evento, cod_tipo_stand, cantidad_estimada, mts2, precio) VALUES
    (1, 1, 50, 100, 5000),  -- Evento1, Tipo Stand 1
    (2, 2, 30, 50, 3000),   -- Evento2, Tipo Stand 2
    (3, 3, 40, 80, 4000),   -- Evento3, Tipo Stand 3
    (4, 1, 60, 120, 6000),  -- Evento4, Tipo Stand 1
    (5, 2, 25, 40, 2500),   -- Evento5, Tipo Stand 2
    (6, 3, 35, 60, 3500),   -- Evento6, Tipo Stand 3
    (7, 1, 45, 90, 4500),   -- Evento7, Tipo Stand 1
    (8, 2, 28, 45, 2800),   -- Evento8, Tipo Stand 2
    (9, 3, 38, 65, 3800),   -- Evento9, Tipo Stand 3
    (10, 1, 55, 110, 5500), -- Evento10, Tipo Stand 1
    (11, 2, 32, 52, 3200),  -- Evento11, Tipo Stand 2
    (12, 3, 42, 72, 4200),  -- Evento12, Tipo Stand 3
    (13, 1, 58, 116, 5800), -- Evento13, Tipo Stand 1
    (14, 2, 27, 43, 2700),  -- Evento14, Tipo Stand 2
    (15, 3, 37, 63, 3700),  -- Evento15, Tipo Stand 3
    (1, 2, 50, 100, 5000),    -- Evento1, Tipo Stand 1
    (2, 3, 30, 50, 3000),     -- Evento2, Tipo Stand 2
    (3, 2, 40, 80, 4000),     -- Evento3, Tipo Stand 3
    (4, 2, 60, 120, 6000),    -- Evento4, Tipo Stand 1
    (5, 3, 25, 40, 2500),     -- Evento5, Tipo Stand 2
    (6, 2, 35, 60, 3500),     -- Evento6, Tipo Stand 3
    (7, 2, 45, 90, 4500),     -- Evento7, Tipo Stand 1
    (8, 3, 28, 45, 2800),     -- Evento8, Tipo Stand 2
    (9, 1, 38, 65, 3800),     -- Evento9, Tipo Stand 3
    (10, 2, 55, 110, 5500),   -- Evento10, Tipo Stand 1
    (11, 3, 32, 52, 3200),    -- Evento11, Tipo Stand 2
    (12, 1, 42, 72, 4200),    -- Evento12, Tipo Stand 3
    (13, 2, 58, 116, 5800),   -- Evento13, Tipo Stand 1
    (14, 3, 27, 43, 2700),    -- Evento14, Tipo Stand 2
    (15, 2, 37, 63, 3700);    -- Evento15, Tipo Stand 3

-- Insertar datos en la tabla CONTRATO para cada evento
INSERT INTO CONTRATO (cod_evento, cod_tipo_stand, fecha_alquiler, cod_cliente, mts2, monto, cod_sub_categoria)
VALUES
    (1, 1, '2016-04-15', 1, 50, 5000.00, 1),
    (2, 2, '2017-07-20', 2, 30, 3000.00, 2),
    (3, 3, '2018-10-25', 3, 40, 4000.00, 3),
    (4, 1, '2019-01-10', 4, 60, 6000.00, 4),
    (5, 2, '2020-03-05', 5, 25, 2500.00, 5),
    (6, 3, '2021-06-15', 6, 35, 3500.00, 6),
    (7, 1, '2022-08-22', 7, 45, 4500.00, 7),
    (8, 2, '2023-11-01', 8, 28, 2800.00, 1),
    (9, 3, '2024-01-14', 9, 38, 3800.00, 2),
    (10, 1, '2024-05-30', 10, 55, 5500.00, 3),
    (11, 2, '2017-09-12', 11, 32, 3200.00, 4),
    (12, 3, '2019-11-18', 12, 42, 4200.00, 5),
    (13, 1, '2020-02-25', 13, 58, 5800.00, 6),
    (14, 2, '2021-04-08', 14, 27, 2700.00, 7),
    (15, 3, '2022-07-01', 15, 37, 3700.00, 1),
    (1, 2, '2016-04-15', 1, 50, 5000.00, 1),
    (2, 3, '2017-07-20', 2, 30, 3000.00, 2),
    (4, 2, '2019-01-10', 4, 60, 6000.00, 4),
    (5, 3, '2020-03-05', 5, 25, 2500.00, 5),
    (7, 2, '2022-08-22', 7, 45, 4500.00, 7),
    (13, 1, '2020-02-25', 8, 58, 5800.00, 6),
    (14, 2, '2021-04-08', 8, 27, 2700.00, 7),
    (7, 2, '2022-08-22', 8, 28, 2800.00, 1),
    (8, 3, '2023-11-01', 8, 28, 2800.00, 1),
    (9, 1, '2024-01-14', 9, 38, 3800.00, 2),
    (10, 2, '2024-05-30', 10, 55, 5500.00, 3),
    (11, 3, '2017-09-12', 11, 32, 3200.00, 4),
    (12, 1, '2019-11-18', 12, 42, 4200.00, 5),
    (13, 2, '2020-02-25', 13, 58, 5800.00, 6),
    (14, 3, '2021-04-08', 14, 27, 2700.00, 7);
-- cliente 8 deberia estar en clientes recurrentes (Gabriela Jimenez)

-- Reiniciar la secuencia para nro_stand en la tabla CONTRATO
ALTER SEQUENCE contrato_nro_stand_seq RESTART WITH 1;

-- Actualizar los valores existentes de nro_stand
UPDATE CONTRATO SET nro_stand = nextval('contrato_nro_stand_seq');

-- Insertar 30 datos en la tabla VISITANTE
INSERT INTO VISITANTE (cedula, nb_visitante, sexo, email)
VALUES
    ('V123456789', 'Juan Pérez', 'M', 'juan@example.com'),
    ('V987654321', 'María López', 'F', 'maria@example.com'),
    ('V567890123', 'Pedro Rodríguez', 'M', 'pedro@example.com'),
    ('V321098765', 'Ana Martínez', 'F', 'ana@example.com'),
    ('V135792468', 'Carlos Gutiérrez', 'M', 'carlos@example.com'),
    ('V246801357', 'Laura Ramírez', 'F', 'laura@example.com'),
    ('V112233445', 'Javier Sánchez', 'M', 'javier@example.com'),
    ('V556677889', 'Sofía Díaz', 'F', 'sofia@example.com'),
    ('V990011223', 'Eduardo Castro', 'M', 'eduardo@example.com'),
    ('V334455667', 'Isabel Vargas', 'F', 'isabel@example.com'),
    ('V778899001', 'Luis Herrera', 'M', 'luis@example.com'),
    ('V667788990', 'Marta Jiménez', 'F', 'marta@example.com'),
    ('V112233445', 'Jorge Medina', 'M', 'jorge@example.com'),
    ('V990011223', 'Carmen Morales', 'F', 'carmen@example.com'),
    ('V334455667', 'Gabriel Silva', 'M', 'gabriel@example.com'),
    ('V778899001', 'Ana Hernández', 'F', 'ana_h@example.com'),
    ('V667788990', 'José Pérez', 'M', 'jose@example.com'),
    ('V112233445', 'Silvia Rodríguez', 'F', 'silvia@example.com'),
    ('V990011223', 'Raúl Martínez', 'M', 'raul@example.com'),
    ('V334455667', 'Lorena Sánchez', 'F', 'lorena@example.com'),
    ('V778899001', 'Diego González', 'M', 'diego@example.com'),
    ('V667788990', 'Patricia Mendoza', 'F', 'patricia@example.com'),
    ('V112233445', 'Hugo Ramírez', 'M', 'hugo@example.com'),
    ('V990011223', 'Carolina Gómez', 'F', 'carolina@example.com'),
    ('V334455667', 'Alberto López', 'M', 'alberto@example.com'),
    ('V778899001', 'Liliana Torres', 'F', 'liliana@example.com'),
    ('V667788990', 'Martín Flores', 'M', 'martin@example.com'),
    ('V112233445', 'Laura Serrano', 'F', 'laura_s@example.com'),
    ('V990011223', 'Ricardo Díaz', 'M', 'ricardo@example.com'),
    ('V334455667', 'Natalia Ruiz', 'F', 'natalia@example.com');

-- Insertar datos en la tabla ENTRADA
INSERT INTO ENTRADA (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas)
VALUES
    (1, '2016-05-15', '18:00:00', 1, true, 4, 5),
    (2, '2017-08-20', '19:30:00', 2, false, 3, 4),
    (3, '2018-11-25', '15:45:00', 3, true, 5, 5),
    (4, '2019-02-10', '21:00:00', 4, false, 2, 3),
    (5, '2020-04-05', '14:20:00', 5, true, 4, 4),
    (6, '2021-07-15', '17:45:00', 6, false, 5, 5),
    (7, '2022-09-22', '20:10:00', 7, true, 3, 3),
    (8, '2023-12-01', '22:30:00', 8, false, 4, 4),
    (9, '2024-02-14', '16:15:00', 9, true, 5, 5),
    (10, '2024-06-30', '19:00:00', 10, false, 4, 4),
    (11, '2017-10-12', '18:45:00', 11, true, 3, 3),
    (12, '2018-12-18', '20:20:00', 12, false, 2, 2),
    (13, '2019-03-25', '14:55:00', 13, true, 4, 4),
    (14, '2020-05-08', '17:30:00', 14, false, 5, 5),
    (15, '2021-08-01', '19:45:00', 15, true, 3, 3),
    (1, '2016-05-15', '18:00:00', 1, true, 4, 5),
    (2, '2017-08-20', '19:30:00', 2, false, 3, 4),
    (4, '2019-02-10', '21:00:00', 4, false, 2, 3),
    (5, '2020-04-05', '14:20:00', 5, true, 4, 4),
    (7, '2022-08-22', '20:10:00', 7, true, 3, 3),
    (13, '2020-02-25', '16:15:00', 8, true, 5, 5),
    (14, '2021-04-08', '19:00:00', 8, false, 4, 4),
    (7, '2022-08-22', '22:30:00', 8, true, 5, 5),
    (8, '2023-11-01', '18:45:00', 8, false, 3, 3),
    (9, '2024-01-14', '20:20:00', 9, true, 2, 2),
    (10, '2024-05-30', '14:55:00', 10, false, 4, 4),
    (11, '2017-09-12', '17:30:00', 11, true, 5, 5),
    (12, '2019-11-18', '19:45:00', 12, false, 3, 3),
    (13, '2020-02-25', '22:00:00', 13, true, 4, 4),
    (14, '2021-04-08', '16:30:00', 14, false, 5, 5);

-- Insertar datos adicionales en la tabla ENTRADA
    -- Insertar datos en la tabla ENTRADA
INSERT INTO ENTRADA (cod_evento, fecha_entrada, hora_entrada, cod_visitante, recomienda_amigo, calificacion, cod_leyenda_estrellas)
VALUES
    (1, '2016-05-15', '18:00:00', 1, true, 4, 5),
    (2, '2017-08-20', '19:30:00', 2, false, 3, 4),
    (3, '2018-11-25', '15:45:00', 3, true, 5, 5),
    (4, '2019-02-10', '21:00:00', 4, false, 2, 3),
    (5, '2020-04-05', '14:20:00', 5, true, 4, 4),
    (6, '2021-07-15', '17:45:00', 6, false, 5, 5),
    (7, '2022-09-22', '20:10:00', 7, true, 3, 3),
    (8, '2023-12-01', '22:30:00', 8, false, 4, 4),
    (9, '2024-02-14', '16:15:00', 9, true, 5, 5),
    (10, '2024-06-30', '19:00:00', 10, false, 4, 4),
    (11, '2017-10-12', '18:45:00', 11, true, 3, 3),
    (12, '2018-12-18', '20:20:00', 12, false, 2, 2),
    (13, '2019-03-25', '14:55:00', 13, true, 4, 4),
    (14, '2020-05-08', '17:30:00', 14, false, 5, 5),
    (15, '2021-08-01', '19:45:00', 15, true, 3, 3),
    (1, '2016-05-15', '18:00:00', 1, true, 4, 5),
    (2, '2017-08-20', '19:30:00', 2, false, 3, 4),
    (4, '2019-02-10', '21:00:00', 4, false, 2, 3),
    (5, '2020-04-05', '14:20:00', 5, true, 4, 4),
    (7, '2022-08-22', '20:10:00', 7, true, 3, 3),
    (13, '2020-02-25', '16:15:00', 8, true, 5, 5),
    (14, '2021-04-08', '19:00:00', 8, false, 4, 4),
    (7, '2022-08-22', '22:30:00', 8, true, 5, 5),
    (8, '2023-11-01', '18:45:00', 8, false, 3, 3),
    (9, '2024-01-14', '20:20:00', 9, true, 2, 2),
    (10, '2024-05-30', '14:55:00', 10, false, 4, 4),
    (11, '2017-09-12', '17:30:00', 11, true, 5, 5),
    (12, '2019-11-18', '19:45:00', 12, false, 3, 3),
    (13, '2020-02-25', '22:00:00', 13, true, 4, 4),
    (14, '2021-04-08', '16:30:00', 14, false, 5, 5),
    (3, '2018-11-26', '16:30:00', 16, true, 5, 5),
    (6, '2021-07-16', '21:15:00', 17, false, 4, 4),
    (9, '2024-02-15', '14:00:00', 18, true, 3, 3),
    (12, '2018-12-19', '17:45:00', 19, false, 2, 2),
    (15, '2021-08-02', '19:30:00', 20, true, 4, 4),
    (1, '2016-05-16', '22:00:00', 21, false, 5, 5),
    (4, '2019-02-11', '15:45:00', 22, true, 3, 3),
    (7, '2022-08-23', '18:30:00', 23, false, 4, 4),
    (10, '2024-07-01', '20:15:00', 24, true, 2, 2),
    (13, '2019-03-26', '14:45:00', 25, false, 5, 5),
    (2, '2017-08-21', '21:30:00', 26, true, 4, 4),
    (5, '2020-04-06', '16:15:00', 27, false, 3, 3),
    (8, '2023-12-02', '19:00:00', 28, true, 2, 2),
    (11, '2017-09-13', '22:30:00', 29, false, 4, 4),
    (14, '2021-04-09', '18:45:00', 30, true, 5, 5);
