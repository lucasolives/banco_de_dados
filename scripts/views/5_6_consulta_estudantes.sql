SELECT
	e.matricula,
	e.nome,
	STRING_AGG(c.nome, ', ') AS curso,
	COALESCE(STRING_AGG(g.titulo, ', '), 'Sem grupo de intervenção') AS grupos,
	TO_CHAR(e.data_ingresso, 'DD/MM/YYYY') AS ingresso,
	ed.semestre || '/' || c.total_periodos AS qtd_semestres,
	ed.turmas
FROM estatisticas_desempenho ed
	INNER JOIN estudante e ON ed.id_estudante = e.id
	LEFT JOIN curso c ON e.id_curso = c.id
	LEFT JOIN estudante_grupo eg ON e.id = eg.id_estudante
	LEFT JOIN grupo g ON eg.id_grupo = g.id
GROUP BY
	e.matricula,
	e.nome,
	e.data_ingresso,
	ed.semestre,
	c.total_periodos,
	ed.turmas;
