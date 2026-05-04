SELECT
	m.matricula,
	e.nome,
	STRING_AGG(c.nome, ', ') AS curso,
	COALESCE(STRING_AGG(g.titulo, ', '), 'Sem grupo de intervenção') AS grupos,
	TO_CHAR(m.data_ingresso, 'DD/MM/YYYY') AS ingresso,
	(
        (EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM m.data_ingresso)) * 2 + CASE WHEN (EXTRACT(MONTH FROM CURRENT_DATE) - EXTRACT(MONTH FROM m.data_ingresso) > 6) THEN 1 ELSE 0 END
	) + 1|| '/' || c.total_periodos AS qtd_semestres,
	COUNT(mt.id_turma) AS turmas
FROM matricula m
	INNER JOIN estudante e ON m.id_estudante = e.id
	LEFT JOIN curso c ON m.id_curso = c.id
	LEFT JOIN matricula_grupo mg ON m.id = mg.id_matricula
	LEFT JOIN grupo g ON mg.id_grupo = g.id
	RIGHT JOIN matricula_turma mt ON mt.id_matricula = m.id
WHERE c.id = 4
GROUP BY
	m.matricula,
	e.nome,
	g.titulo,
	m.data_ingresso,
	c.total_periodos,
	mt.id_turma;
