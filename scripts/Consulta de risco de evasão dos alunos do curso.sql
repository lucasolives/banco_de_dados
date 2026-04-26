SELECT 
	ed.risco,
	ed.semestre_saida,
	e.matricula,
	e.nome,
	ed.media_global,
	ed.semestre,
	ed.reprovacoes,
	ed.ch_semestre,
	ed.maior_influencia_evasao,
	ed.turmas
FROM estatisticas_desempenho ed
INNER JOIN estudante e ON ed.id_estudante = e.matricula
