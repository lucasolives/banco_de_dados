BEGIN;

-- Desassociar um estudante de uma intervenção específica
DELETE FROM public.estudante_intervencao
WHERE id_estudante = 1 AND id_intervencao = 2;

-- Remover uma intervenção (CASCADE apaga estudante_intervencao)
DELETE FROM public.intervencao
WHERE id = 5;

-- Remover um estudante de um grupo
DELETE FROM public.estudante_grupo
WHERE id_estudante = 3 AND id_grupo = 1;

-- Remover um grupo (CASCADE apaga estudante_grupo)
DELETE FROM public.grupo
WHERE id = 5;

-- Remover vínculo de usuário com curso
DELETE FROM public.usuario_curso
WHERE id_usuario = 2 AND id_curso = 2;

-- Remover um usuário (CASCADE apaga usuario_curso e intervencoes)
DELETE FROM public.usuario
WHERE id = 5;

COMMIT;
