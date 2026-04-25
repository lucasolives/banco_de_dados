SELECT usuario.nome, usuario.email, permissoes_usuario.cargo, curso.nome, usuario.ultimo_acesso
FROM perfil
INNER JOIN usuario ON usuario.id_usuario = perfil.id_usuario
INNER JOIN permissoes_usuario ON permissoes_usuario.id_permissao = perfil.id_permissao
INNER JOIN curso ON curso.id_curso = perfil.id_curso
WHERE curso.id_instituicao = 200;
