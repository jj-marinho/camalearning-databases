DROP TABLE IF EXISTS modalidades;
CREATE TABLE modalidades (
    id INTEGER PRIMARY KEY,
    descricao TEXT
);

DROP TABLE IF EXISTS cursos;
CREATE TABLE cursos (
    id INTEGER PRIMARY KEY,
    nome TEXT,
    tipo TEXT,
    periodo TEXT,
    vagas INTEGER,
    campus TEXT,
    cidade TEXT,
    estado TEXT,
    universidade TEXT,
    sigla TEXT
);

DROP TABLE IF EXISTS resultados;
CREATE TABLE resultados (
    id_curso INTEGER,
    nome_curso TEXT,
    id_modalidade INTEGER,
    vagas INTEGER,
    nota_minima DOUBLE PRECISION,
    bonus DOUBLE PRECISION,
    data_informacao TEXT,
    PRIMARY KEY (id_curso, id_modalidade)
);

