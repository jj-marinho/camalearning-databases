DROP VIEW IF EXISTS media_corte;
CREATE VIEW media_corte AS

SELECT 
    a.nome, c.descricao AS descricao_modalidade,
    AVG(b.nota_minima), MAX(b.nota_minima), MIN(b.nota_minima)

FROM cursos A
JOIN resultados B ON b.id_curso = a.id
JOIN modalidades C ON c.id = b.id_modalidade

GROUP BY a.nome, c.descricao