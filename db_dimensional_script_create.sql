-- Tabla DIM_SEDE
CREATE TABLE dim_sede (
  sk_sede NUMERIC PRIMARY KEY,
  cod_pais NUMERIC,
  nb_pais VARCHAR(100),
  cod_ciudad NUMERIC,
  nb_ciudad VARCHAR(100),
  nb_sede VARCHAR(100)
);

-- Tabla DIM_EVENTO
CREATE TABLE dim_evento (
  sk_evento NUMERIC PRIMARY KEY,
  cod_tipo_evento NUMERIC,
  nb_tipo_evento VARCHAR(100),
  cod_evento NUMERIC,
  ne_evento VARCHAR(100),
  descripcion VARCHAR(100),
  sk_sede NUMERIC REFERENCES dim_sede (sk_sede)
);

-- Tabla DIM_TIPO_STAND
CREATE TABLE dim_tipo_stand (
  sk_tipo_stand NUMERIC PRIMARY KEY,
  cod_tipo_stand NUMERIC,
  ne_tipo_stand VARCHAR(100),
  meta_ingreso NUMERIC(10,4)
);

-- Tabla FACT_EVENTO_STAND
CREATE TABLE fact_evento_stand (
  sk_evento NUMERIC REFERENCES dim_evento (sk_evento),
  sk_tipo_stand NUMERIC REFERENCES dim_tipo_stand (sk_tipo_stand),
  cantidad_estimada NUMERIC,
  mt2 NUMERIC(10,4),
  precio NUMERIC(10,4)
);

-- Tabla DIM_LEYENDA
CREATE TABLE dim_leyenda (
  sk_leyenda NUMERIC PRIMARY KEY,
  cod_leyenda NUMERIC,
  nb_leyenda VARCHAR(100)
);

-- Tabla FACT_VISITA
CREATE TABLE fact_visita (
  sk_evento NUMERIC REFERENCES dim_evento (sk_evento),
  sk_visitante NUMERIC REFERENCES dim_visitante (sk_visitante),
  sk_leyenda NUMERIC REFERENCES dim_leyenda (sk_leyenda),
  num_entrada NUMERIC PRIMARY KEY,
  hora_entrada TIMESTAMP,
  cantidad_visita NUMERIC,
  calificacion VARCHAR(10),
  recomienda_amigo VARCHAR(100)
);

-- Tabla FACT_ALQUILER
CREATE TABLE fact_alquiler (
  sk_evento NUMERIC REFERENCES dim_evento (sk_evento),
  sk_cliente NUMERIC REFERENCES dim_cliente (sk_cliente),
  sk_fec_alquiler NUMERIC PRIMARY KEY,
  sk_tipo_stand NUMERIC REFERENCES dim_tipo_stand (sk_tipo_stand),
  sk_categoria NUMERIC REFERENCES dim_categoria (sk_categoria),
  num_contrato NUMERIC,
  num_stand NUMERIC,
  mt2 NUMERIC(10,4),
  monto NUMERIC(10,4)
);

-- Tabla DIM_VISITANTE
CREATE TABLE dim_visitante (
  sk_visitante NUMERIC PRIMARY KEY,
  cod_visitante NUMERIC,
  cedula NUMERIC,
  nb_visitante VARCHAR(100),
  sexo VARCHAR(100),
  email VARCHAR(100)
);

-- Tabla DIM_TIEMPO
CREATE TABLE dim_tiempo (
  sk_tiempo NUMERIC PRIMARY KEY,
  cod_anio NUMERIC,
  cod_trimestre NUMERIC,
  des_trimestre VARCHAR(100),
  cod_mes NUMERIC,
  desc_mes VARCHAR(20),
  desc_mes_corta VARCHAR(20),
  cod_semana NUMERIC,
  cod_dia_anio NUMERIC,
  cod_dia_mes NUMERIC,
  cod_dia_semana NUMERIC,
  desc_dia_semana NUMERIC,
  fecha DATE
);

-- Tabla DIM_CLIENTE
CREATE TABLE dim_cliente (
  sk_cliente NUMERIC PRIMARY KEY,
  cod_cliente NUMERIC,
  cirip VARCHAR(100),
  nb_cliente VARCHAR(100),
  telefono VARCHAR(100),
  direccion VARCHAR(100),
  email VARCHAR(100)
);
-- Crear tabla fact_evento
CREATE TABLE fact_evento (
  sk_evento NUMERIC PRIMARY KEY,
  sk_sede NUMERIC REFERENCES dim_sede (sk_sede),
  cod_tipo_evento NUMERIC REFERENCES dim_evento (cod_tipo_evento),
  cantidad_evento NUMERIC,
  cantidad_estim_visitantes NUMERIC,
  meta_ingreso NUMERIC(10,4)
);

-- Agregar claves foraneas

ALTER TABLE fact_evento
ADD CONSTRAINT fk_fact_evento_sk_sede
FOREIGN KEY (sk_sede)
REFERENCES dim_sede (sk_sede);

ALTER TABLE fact_evento
ADD CONSTRAINT fk_fact_evento_cod_tipo_evento
FOREIGN KEY (cod_tipo_evento)
REFERENCES dim_evento (cod_tipo_evento);