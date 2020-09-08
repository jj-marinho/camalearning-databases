COPY modalidades 
FROM '/data/modalidades.csv' 
DELIMITER ';' 
CSV HEADER;

COPY cursos 
FROM '/data/cursos.csv' 
DELIMITER ';' 
CSV HEADER;

COPY resultados 
FROM '/data/resultados.csv' 
DELIMITER ';' 
CSV HEADER;