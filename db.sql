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
    cod_evento INTEGER REFERENCES EVENTO(cod_evento),
    cod_tipo_stand INTEGER REFERENCES TIPO_STAND(cod_tipo_stand),
    fecha_alquiler DATE NOT NULL,
    cod_cliente INTEGER REFERENCES CLIENTE(cod_cliente),
    mts2 INTEGER,
    monto DECIMAL(10,2),
    cod_sub_categoria INTEGER REFERENCES SUBCATEGORIA(cod_sub_categoria)
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

INSERT INTO SUBCATEGORIA (nb_sub_categoria) VALUES
    ('Postres y Dulces'),
    ('Hamburguesas'),
    ('Ropa para Damas');

-- Inserción de valores en la tabla LEYENDA_ESTRELLAS
INSERT INTO LEYENDA_ESTRELLAS (nb_descripcion) VALUES
    ('Malo'),
    ('Regular'),
    ('Bueno'),
    ('Muy Bueno'),
    ('Excelente');
