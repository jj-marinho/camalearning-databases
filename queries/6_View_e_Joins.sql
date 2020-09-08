DROP VIEW IF EXISTS resultado_curso_modalidade;

CREATE VIEW resultado_curso_modalidade AS

SELECT 
    a.nome, a.tipo, a.periodo, a.campus, a.sigla, 
    b.id_curso, b.id_modalidade, b.nota_minima,
    c.descricao AS descricao_modalidade

FROM cursos A
JOIN resultados B ON b.id_curso = a.id
JOIN modalidades C ON c.id = b.id_modalidade