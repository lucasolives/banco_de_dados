SELECT
	ed.risco,
	ed.semestre_saida,
	m.id AS "matrícula",
	e.nome,
	m.media_global,
	(
        (EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM m.data_ingresso)) * 2 + CASE WHEN (EXTRACT(MONTH FROM CURRENT_DATE) - EXTRACT(MONTH FROM m.data_ingresso) > 6) THEN 1 ELSE 0 END
	) + 1 AS "Semestre atual",
	m.reprovacoes,
	SUM(d.carga_horaria) AS "carga horaria",
	ed.maior_influencia_evasao,
	COUNT(mt.id_turma) AS "total turmas"
FROM matricula m
INNER JOIN estatisticas_desempenho ed ON ed.id = m.id_estatisticas_desempenho
INNER JOIN estudante e ON e.id = m.id_estudante
RIGHT JOIN matricula_turma mt ON mt.id_matricula = m.id
INNER JOIN turma t ON t.id = mt.id_turma
INNER JOIN disciplina d ON d.id = t.id_disciplina
GROUP BY ed.risco, ed.semestre_saida, m.id, e.nome, m.media_global,ed.maior_influencia_evasao
ORDER BY m.id
