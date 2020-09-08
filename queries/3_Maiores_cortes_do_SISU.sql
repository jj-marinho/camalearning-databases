SELECT id_curso, nome_curso, id_modalidade, vagas, nota_minima, bonus
FROM resultados

WHERE nota_minima >= 800
AND bonus = 0
