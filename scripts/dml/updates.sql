BEGIN;

-- Atualizar e-mail de um usuário
UPDATE public.usuario
SET email = 'carlos.coord@ufg.edu.br'
WHERE id = 1;

-- Registrar último acesso de um usuário
UPDATE public.usuario
SET ultimo_acesso = CURRENT_TIMESTAMP
WHERE id = 3;

-- Inativar um grupo de intervenção
UPDATE public.grupo
SET ativo = false
WHERE id = 1;

-- Reativar um grupo de intervenção
UPDATE public.grupo
SET ativo = true
WHERE id = 2;

-- Corrigir semestre de uma intervenção (padrão YYYY.1/2)
UPDATE public.intervencao
SET semestre = '2026.2'
WHERE id = 2;

-- Atualizar objetivo alcançado de uma intervenção
UPDATE public.intervencao
SET objetivo_alcancado = 'Sim',
    observacao = 'Objetivo atingido após acompanhamento adicional'
WHERE id = 4;

-- Atualizar risco de evasão de um estudante
UPDATE public.estatisticas_desempenho
SET risco = 0.55,
    reprovacoes = 3,
    semestre = 3
WHERE id_estudante = 1;

-- Transferir estudante de curso
UPDATE public.estudante
SET id_curso = 2
WHERE id = 3;

-- Atualizar nome de perfil
UPDATE public.perfil
SET nome = 'Coordenador de Curso'
WHERE id = 1;

COMMIT;
