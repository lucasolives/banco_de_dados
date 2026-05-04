SELECT
	u.nome,
	u.email AS email_institucional,
	p.nome AS perfil,
	STRING_AGG(c.nome, ', ') AS curso,
	(CURRENT_TIMESTAMP - u.ultimo_acesso) AS ultimo_acesso
FROM usuario u
	INNER JOIN perfil p ON p.id = u.id_perfil
	LEFT JOIN usuario_curso uc ON u.id = uc.id_usuario
	LEFT JOIN curso c ON uc.id_curso= c.id
	INNER JOIN instituicao i ON i.cod_MEC = u.id_instituicao
GROUP BY
	u.nome,
	u.email,
	p.nome,
	u.ultimo_acesso
