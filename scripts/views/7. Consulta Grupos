SELECT
    g.titulo,
    g.semestre,
    COUNT(DISTINCT eg.id_estudante) AS estudantes,
    TO_CHAR(g.data_criacao, 'DD/MM/YYYY') AS criacao,
    g.observacao,
    -- Lógica simples: Se houver curso, concatena ' de ' + lista. Se não, apenas o perfil.
    p.nome || COALESCE(
        (SELECT ' de ' || STRING_AGG(c.nome, ', ') 
         FROM usuario_curso uc 
         JOIN curso c ON uc.id_curso = c.id 
         WHERE uc.id_usuario = g.id_usuario), 
        ''
    ) AS autoria,
    CASE WHEN g.ativo THEN 'Ativo' ELSE 'Inativo' END AS status
FROM grupo g
    INNER JOIN usuario u ON g.id_usuario = u.id
    INNER JOIN perfil p ON u.id_perfil = p.id
    LEFT JOIN estudante_grupo eg ON g.id = eg.id_grupo
GROUP BY 
    g.id, 
	g.titulo, 
	g.semestre, 
	g.data_criacao, 
	g.observacao, 
	u.id, 
	p.nome, 
	g.ativo;
