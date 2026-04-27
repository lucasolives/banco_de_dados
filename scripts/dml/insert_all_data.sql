BEGIN;

-- Carga completa: alinha com DDL (permissoes_usuario com todas as colunas), enunciado
-- (tipo Universidade/Instituto Federal), total_periodos, IFs/unidades/cursos extras e vínculos usuario_curso.

-- ============================================================
-- 1. permissões / perfis
-- (alinha com o DDL: todas as colunas booleanas existem)
-- ============================================================
INSERT INTO public.permissoes_usuario
  (id, super_usuario, deletar_intervencao, editar_intervencao, criar_intervencao, criar_grupo, editar_grupo, deletar_grupo, criar_aluno, visualizar_aluno, visualizar_risco)
VALUES
  (1, true,  true,  true,  true,  true,  true,  true,  true,  true,  true),   -- super usuário
  (2, false, true,  true,  true,  true,  true,  true,  false, true,  true),   -- coordenador de curso
  (3, false, false, true,  true,  true,  true,  false, false, true,  true),   -- tutor
  (4, false, false, false, true,  true,  true,  false, false, true,  true),   -- coordenador de ensino/unidade
  (5, false, false, false, false, false, false, false, false, true,  true);   -- público (somente visualização)

INSERT INTO public.perfil (id, id_permissao, nome) VALUES
  (1, 2, 'Coordenador de Curso'),
  (2, 3, 'Tutor'),
  (3, 4, 'Coordenador de Ensino'),
  (4, 4, 'Coordenador de Unidade'),
  (5, 5, 'Público');

-- ============================================================
-- 2. instituições / unidades / cursos
-- (PDF: instituicao.tipo = Universidade ou Instituto Federal)
-- ============================================================
INSERT INTO public.instituicao (cod_mec, nome, tipo) VALUES
  (101, 'Universidade de Brasília', 'Universidade'),
  (102, 'Universidade Federal de Goiás', 'Universidade'),
  (103, 'Pontifícia Universidade Católica', 'Universidade'),
  (104, 'Instituto Federal de Goiás', 'Instituto Federal'),
  (105, 'Instituto Federal de Brasília', 'Instituto Federal');

INSERT INTO public.unidade (id, id_instituicao, nome, sigla) VALUES
  (1, 101, 'Faculdade de Tecnologia', 'FT'),
  (2, 102, 'Instituto de Informática', 'INF'),
  (3, 103, 'Escola Politécnica', 'POLI'),
  (4, 104, 'Campus Goiânia', 'GO'),
  (5, 105, 'Campus Brasília', 'BSB');

-- total_periodos: solicitado no grupo e existe no DDL
INSERT INTO public.curso (id, id_instituicao, id_unidade, total_periodos, nome) VALUES
  (1, 101, 1, 8, 'Engenharia de Software'),
  (2, 101, 1, 8, 'Ciência da Computação'),
  (3, 102, 2, 8, 'Sistemas de Informação'),
  (4, 103, 3, 10, 'Engenharia de Computação'),
  (5, 104, 4, 6, 'Tecnologia em Redes de Computadores'),
  (6, 105, 5, 6, 'Tecnologia em Sistemas para Internet');

-- ============================================================
-- 3. usuários + vínculo N:N usuário/curso
-- ============================================================
INSERT INTO public.usuario (id, id_instituicao, id_perfil, nome, email) VALUES
  (1, 102, 1, 'Carlos Eduardo Santos', 'carlos.coord@ufg.br'),    -- Coordenador de Curso (Inst 102)
  (2, 101, 2, 'Mariana de Oliveira', 'mariana.tutor@unb.br'),     -- Tutor (Inst 101)
  (3, 103, 3, 'Fernanda Lima', 'fernanda.ensino@puc.br'),         -- Coordenador de Ensino
  (4, 101, 4, 'Roberto Alves', 'roberto.unidade@unb.br'),         -- Coordenador de Unidade
  (5, 102, 5, 'Lucas Pereira', 'lucas.publico@gmail.com');        -- Público

INSERT INTO public.usuario_curso (id_usuario, id_curso) VALUES
  (2, 1),
  (2, 2),
  (1, 3),
  (3, 4),
  (4, 2),
  (4, 1);

-- ============================================================
-- 4. disciplinas / turmas
-- ============================================================
INSERT INTO public.disciplina (id, id_curso, nome, carga_horaria) VALUES
  -- Unidade 1 (Inst 101)
  (1, 1, 'Arquitetura de Software', 60),
  (2, 1, 'Testes de Software', 60),
  (3, 1, 'Requisitos', 60),
  (4, 2, 'Estrutura de Dados', 90),
  (5, 2, 'Algoritmos', 90),
  -- Unidade 2 (Inst 102)
  (6, 3, 'Banco de Dados I', 60),
  (7, 3, 'Redes de Computadores', 60),
  (8, 3, 'Sistemas Operacionais', 60),
  (9, 3, 'Governança de TI', 60),
  (10, 3, 'Gestão de Projetos', 60),
  -- Unidade 3 (Inst 103)
  (11, 4, 'Cálculo I', 90),
  (12, 4, 'Física I', 90),
  (13, 4, 'Geometria Analítica', 60),
  (14, 4, 'Eletrônica Digital', 60),
  (15, 4, 'Lógica de Programação', 90);

INSERT INTO public.turma (id, id_disciplina, nome) VALUES
  (1, 1, 'Turma T1'), (2, 2, 'Turma T2'), (3, 3, 'Turma T3'), (4, 4, 'Turma T4'), (5, 5, 'Turma T5'),
  (6, 6, 'Turma T6'), (7, 7, 'Turma T7'), (8, 8, 'Turma T8'), (9, 9, 'Turma T9'), (10, 10, 'Turma T10'),
  (11, 11, 'Turma T11'), (12, 12, 'Turma T12'), (13, 13, 'Turma T13'), (14, 14, 'Turma T14'), (15, 15, 'Turma T15');

-- ============================================================
-- 5. estudantes / matrícula em turmas
-- ============================================================
INSERT INTO public.estudante (id, id_instituicao, id_curso, matricula, nome, data_ingresso) VALUES
  -- Inst 101, Curso 1 (Alunos 1 a 15)
  (1, 101, 1, 26001, 'aluno_1', '2026-02-15'), (2, 101, 1, 26002, 'aluno_2', '2026-02-15'), (3, 101, 1, 26003, 'aluno_3', '2026-02-15'), (4, 101, 1, 26004, 'aluno_4', '2026-02-15'), (5, 101, 1, 26005, 'aluno_5', '2026-02-15'),
  (6, 101, 1, 26006, 'aluno_6', '2026-02-15'), (7, 101, 1, 26007, 'aluno_7', '2026-02-15'), (8, 101, 1, 26008, 'aluno_8', '2026-02-15'), (9, 101, 1, 26009, 'aluno_9', '2026-02-15'), (10, 101, 1, 26010, 'aluno_10', '2026-02-15'),
  (11, 101, 1, 26011, 'aluno_11', '2026-02-15'), (12, 101, 1, 26012, 'aluno_12', '2026-02-15'), (13, 101, 1, 26013, 'aluno_13', '2026-02-15'), (14, 101, 1, 26014, 'aluno_14', '2026-02-15'), (15, 101, 1, 26015, 'aluno_15', '2026-02-15'),
  -- Inst 101, Curso 2 (Alunos 16 a 25)
  (16, 101, 2, 26016, 'aluno_16', '2026-02-15'), (17, 101, 2, 26017, 'aluno_17', '2026-02-15'), (18, 101, 2, 26018, 'aluno_18', '2026-02-15'), (19, 101, 2, 26019, 'aluno_19', '2026-02-15'), (20, 101, 2, 26020, 'aluno_20', '2026-02-15'),
  (21, 101, 2, 26021, 'aluno_21', '2026-02-15'), (22, 101, 2, 26022, 'aluno_22', '2026-02-15'), (23, 101, 2, 26023, 'aluno_23', '2026-02-15'), (24, 101, 2, 26024, 'aluno_24', '2026-02-15'), (25, 101, 2, 26025, 'aluno_25', '2026-02-15'),
  -- Inst 102, Curso 3 (Alunos 26 a 50)
  (26, 102, 3, 26026, 'aluno_26', '2026-02-15'), (27, 102, 3, 26027, 'aluno_27', '2026-02-15'), (28, 102, 3, 26028, 'aluno_28', '2026-02-15'), (29, 102, 3, 26029, 'aluno_29', '2026-02-15'), (30, 102, 3, 26030, 'aluno_30', '2026-02-15'),
  (31, 102, 3, 26031, 'aluno_31', '2026-02-15'), (32, 102, 3, 26032, 'aluno_32', '2026-02-15'), (33, 102, 3, 26033, 'aluno_33', '2026-02-15'), (34, 102, 3, 26034, 'aluno_34', '2026-02-15'), (35, 102, 3, 26035, 'aluno_35', '2026-02-15'),
  (36, 102, 3, 26036, 'aluno_36', '2026-02-15'), (37, 102, 3, 26037, 'aluno_37', '2026-02-15'), (38, 102, 3, 26038, 'aluno_38', '2026-02-15'), (39, 102, 3, 26039, 'aluno_39', '2026-02-15'), (40, 102, 3, 26040, 'aluno_40', '2026-02-15'),
  (41, 102, 3, 26041, 'aluno_41', '2026-02-15'), (42, 102, 3, 26042, 'aluno_42', '2026-02-15'), (43, 102, 3, 26043, 'aluno_43', '2026-02-15'), (44, 102, 3, 26044, 'aluno_44', '2026-02-15'), (45, 102, 3, 26045, 'aluno_45', '2026-02-15'),
  (46, 102, 3, 26046, 'aluno_46', '2026-02-15'), (47, 102, 3, 26047, 'aluno_47', '2026-02-15'), (48, 102, 3, 26048, 'aluno_48', '2026-02-15'), (49, 102, 3, 26049, 'aluno_49', '2026-02-15'), (50, 102, 3, 26050, 'aluno_50', '2026-02-15'),
  -- Inst 103, Curso 4 (Alunos 51 a 75)
  (51, 103, 4, 26051, 'aluno_51', '2026-02-15'), (52, 103, 4, 26052, 'aluno_52', '2026-02-15'), (53, 103, 4, 26053, 'aluno_53', '2026-02-15'), (54, 103, 4, 26054, 'aluno_54', '2026-02-15'), (55, 103, 4, 26055, 'aluno_55', '2026-02-15'),
  (56, 103, 4, 26056, 'aluno_56', '2026-02-15'), (57, 103, 4, 26057, 'aluno_57', '2026-02-15'), (58, 103, 4, 26058, 'aluno_58', '2026-02-15'), (59, 103, 4, 26059, 'aluno_59', '2026-02-15'), (60, 103, 4, 26060, 'aluno_60', '2026-02-15'),
  (61, 103, 4, 26061, 'aluno_61', '2026-02-15'), (62, 103, 4, 26062, 'aluno_62', '2026-02-15'), (63, 103, 4, 26063, 'aluno_63', '2026-02-15'), (64, 103, 4, 26064, 'aluno_64', '2026-02-15'), (65, 103, 4, 26065, 'aluno_65', '2026-02-15'),
  (66, 103, 4, 26066, 'aluno_66', '2026-02-15'), (67, 103, 4, 26067, 'aluno_67', '2026-02-15'), (68, 103, 4, 26068, 'aluno_68', '2026-02-15'), (69, 103, 4, 26069, 'aluno_69', '2026-02-15'), (70, 103, 4, 26070, 'aluno_70', '2026-02-15'),
  (71, 103, 4, 26071, 'aluno_71', '2026-02-15'), (72, 103, 4, 26072, 'aluno_72', '2026-02-15'), (73, 103, 4, 26073, 'aluno_73', '2026-02-15'), (74, 103, 4, 26074, 'aluno_74', '2026-02-15'), (75, 103, 4, 26075, 'aluno_75', '2026-02-15');

INSERT INTO public.estudante_turma (id_estudante, id_turma) VALUES
  (1,1), (2,1), (3,1), (4,1), (5,1),
  (6,2), (7,2), (8,2), (9,2), (10,2),
  (11,3), (12,3), (13,3), (14,3), (15,3),
  (16,4), (17,4), (18,4), (19,4), (20,4),
  (21,5), (22,5), (23,5), (24,5), (25,5),
  (26,6), (27,6), (28,6), (29,6), (30,6),
  (31,7), (32,7), (33,7), (34,7), (35,7),
  (36,8), (37,8), (38,8), (39,8), (40,8),
  (41,9), (42,9), (43,9), (44,9), (45,9),
  (46,10), (47,10), (48,10), (49,10), (50,10),
  (51,11), (52,11), (53,11), (54,11), (55,11),
  (56,12), (57,12), (58,12), (59,12), (60,12),
  (61,13), (62,13), (63,13), (64,13), (65,13),
  (66,14), (67,14), (68,14), (69,14), (70,14),
  (71,15), (72,15), (73,15), (74,15), (75,15);

-- ============================================================
-- 6. estatísticas (1 por estudante)
-- ============================================================
INSERT INTO public.estatisticas_desempenho (id_estudante, media_global, semestre, reprovacoes, ch_semestre, turmas, maior_influencia_evasao, risco) VALUES
  (1, 9.5, 1, 0, 360, 5, 'Nenhuma', 0.05), (2, 7.5, 1, 1, 300, 5, 'Financeiro', 0.25), (3, 5.5, 1, 3, 240, 5, 'Conteúdo', 0.50), (4, 4.0, 1, 4, 180, 5, 'Desmotivação', 0.75), (5, 2.0, 1, 6, 120, 5, 'Saúde/Trabalho', 0.95),
  (6, 9.5, 1, 0, 360, 5, 'Nenhuma', 0.05), (7, 7.5, 1, 1, 300, 5, 'Financeiro', 0.25), (8, 5.5, 1, 3, 240, 5, 'Conteúdo', 0.50), (9, 4.0, 1, 4, 180, 5, 'Desmotivação', 0.75), (10, 2.0, 1, 6, 120, 5, 'Saúde/Trabalho', 0.95),
  (11, 9.5, 1, 0, 360, 5, 'Nenhuma', 0.05), (12, 7.5, 1, 1, 300, 5, 'Financeiro', 0.25), (13, 5.5, 1, 3, 240, 5, 'Conteúdo', 0.50), (14, 4.0, 1, 4, 180, 5, 'Desmotivação', 0.75), (15, 2.0, 1, 6, 120, 5, 'Saúde/Trabalho', 0.95),
  (16, 9.5, 1, 0, 360, 5, 'Nenhuma', 0.05), (17, 7.5, 1, 1, 300, 5, 'Financeiro', 0.25), (18, 5.5, 1, 3, 240, 5, 'Conteúdo', 0.50), (19, 4.0, 1, 4, 180, 5, 'Desmotivação', 0.75), (20, 2.0, 1, 6, 120, 5, 'Saúde/Trabalho', 0.95),
  (21, 9.5, 1, 0, 360, 5, 'Nenhuma', 0.05), (22, 7.5, 1, 1, 300, 5, 'Financeiro', 0.25), (23, 5.5, 1, 3, 240, 5, 'Conteúdo', 0.50), (24, 4.0, 1, 4, 180, 5, 'Desmotivação', 0.75), (25, 2.0, 1, 6, 120, 5, 'Saúde/Trabalho', 0.95),
  (26, 9.5, 1, 0, 360, 5, 'Nenhuma', 0.05), (27, 7.5, 1, 1, 300, 5, 'Financeiro', 0.25), (28, 5.5, 1, 3, 240, 5, 'Conteúdo', 0.50), (29, 4.0, 1, 4, 180, 5, 'Desmotivação', 0.75), (30, 2.0, 1, 6, 120, 5, 'Saúde/Trabalho', 0.95),
  (31, 9.5, 1, 0, 360, 5, 'Nenhuma', 0.05), (32, 7.5, 1, 1, 300, 5, 'Financeiro', 0.25), (33, 5.5, 1, 3, 240, 5, 'Conteúdo', 0.50), (34, 4.0, 1, 4, 180, 5, 'Desmotivação', 0.75), (35, 2.0, 1, 6, 120, 5, 'Saúde/Trabalho', 0.95),
  (36, 9.5, 1, 0, 360, 5, 'Nenhuma', 0.05), (37, 7.5, 1, 1, 300, 5, 'Financeiro', 0.25), (38, 5.5, 1, 3, 240, 5, 'Conteúdo', 0.50), (39, 4.0, 1, 4, 180, 5, 'Desmotivação', 0.75), (40, 2.0, 1, 6, 120, 5, 'Saúde/Trabalho', 0.95),
  (41, 9.5, 1, 0, 360, 5, 'Nenhuma', 0.05), (42, 7.5, 1, 1, 300, 5, 'Financeiro', 0.25), (43, 5.5, 1, 3, 240, 5, 'Conteúdo', 0.50), (44, 4.0, 1, 4, 180, 5, 'Desmotivação', 0.75), (45, 2.0, 1, 6, 120, 5, 'Saúde/Trabalho', 0.95),
  (46, 9.5, 1, 0, 360, 5, 'Nenhuma', 0.05), (47, 7.5, 1, 1, 300, 5, 'Financeiro', 0.25), (48, 5.5, 1, 3, 240, 5, 'Conteúdo', 0.50), (49, 4.0, 1, 4, 180, 5, 'Desmotivação', 0.75), (50, 2.0, 1, 6, 120, 5, 'Saúde/Trabalho', 0.95),
  (51, 9.5, 1, 0, 360, 5, 'Nenhuma', 0.05), (52, 7.5, 1, 1, 300, 5, 'Financeiro', 0.25), (53, 5.5, 1, 3, 240, 5, 'Conteúdo', 0.50), (54, 4.0, 1, 4, 180, 5, 'Desmotivação', 0.75), (55, 2.0, 1, 6, 120, 5, 'Saúde/Trabalho', 0.95),
  (56, 9.5, 1, 0, 360, 5, 'Nenhuma', 0.05), (57, 7.5, 1, 1, 300, 5, 'Financeiro', 0.25), (58, 5.5, 1, 3, 240, 5, 'Conteúdo', 0.50), (59, 4.0, 1, 4, 180, 5, 'Desmotivação', 0.75), (60, 2.0, 1, 6, 120, 5, 'Saúde/Trabalho', 0.95),
  (61, 9.5, 1, 0, 360, 5, 'Nenhuma', 0.05), (62, 7.5, 1, 1, 300, 5, 'Financeiro', 0.25), (63, 5.5, 1, 3, 240, 5, 'Conteúdo', 0.50), (64, 4.0, 1, 4, 180, 5, 'Desmotivação', 0.75), (65, 2.0, 1, 6, 120, 5, 'Saúde/Trabalho', 0.95),
  (66, 9.5, 1, 0, 360, 5, 'Nenhuma', 0.05), (67, 7.5, 1, 1, 300, 5, 'Financeiro', 0.25), (68, 5.5, 1, 3, 240, 5, 'Conteúdo', 0.50), (69, 4.0, 1, 4, 180, 5, 'Desmotivação', 0.75), (70, 2.0, 1, 6, 120, 5, 'Saúde/Trabalho', 0.95),
  (71, 9.5, 1, 0, 360, 5, 'Nenhuma', 0.05), (72, 7.5, 1, 1, 300, 5, 'Financeiro', 0.25), (73, 5.5, 1, 3, 240, 5, 'Conteúdo', 0.50), (74, 4.0, 1, 4, 180, 5, 'Desmotivação', 0.75), (75, 2.0, 1, 6, 120, 5, 'Saúde/Trabalho', 0.95);

-- ============================================================
-- 7. grupos / N:N estudante_grupo
-- ============================================================
INSERT INTO public.grupo (id, id_usuario, titulo, semestre, ativo, observacao) VALUES
  (1, 2, 'Monitoria de Lógica', '2026.1', true, 'Apoio extra-classe'),
  (2, 1, 'Iniciação Científica', '2026.1', true, 'Pesquisa Avançada'),
  (3, 2, 'Apoio em Estrutura de Dados', '2026.1', true, 'Foco prático'),
  (4, 1, 'Saúde Mental no Campus', '2026.1', true, 'Roda de conversa'),
  (5, 3, 'Nivelamento de Cálculo', '2026.1', true, 'Revisão matemática básica');

INSERT INTO public.estudante_grupo (id_grupo, id_estudante) VALUES
  (1, 3), (1, 4), (1, 5),
  (2, 1), (2, 6), (2, 11),
  (3, 19), (3, 20),
  (4, 10), (4, 15), (4, 25),
  (5, 53), (5, 54), (5, 55);

-- ============================================================
-- 8. intervenções / N:N estudante_intervencao
-- (respeita CHECKs: tipo/acompanhamento/objetivo_alcancado)
-- ============================================================
INSERT INTO public.intervencao (id, id_usuario, id_disciplina, id_curso, semestre, forma, formato, interacao, assunto, tipo, acompanhamento, objetivo_alcancado, duracao) VALUES
  (1, 1, 6, 3, '2026.1', 'Chat Online', 'individual', 'pró-ativa', 'Aviso de Notas Baixas', 'Conteudo', 'Sincrono', 'Nao', 30),
  (2, 2, 1, 1, '2026.1', 'Aviso Moodle', 'grupo', 'reativa', 'Dúvidas Arquitetura', 'Conteudo', 'Assincrono', 'Sim', 15),
  (3, 1, NULL, 3, '2026.1', 'Encaminhamento Médico', 'individual', 'pró-ativa', 'Apoio Emocional', 'Acolhimento', 'Sincrono', 'Parcialmente', 60),
  (4, 2, NULL, 2, '2026.1', 'E-mail em Massa', 'grupo', 'reativa', 'Prazos de Matrícula', 'Outro', 'Assincrono', 'Sim', 10),
  (5, 3, 11, 4, '2026.1', 'Reunião Presencial', 'individual', 'reativa', 'Dificuldade em Cálculo', 'Conteudo', 'Sincrono', 'Nao', 45);

INSERT INTO public.estudante_intervencao (id_intervencao, id_estudante) VALUES
  (1, 30),
  (2, 1), (2, 2), (2, 3), (2, 4), (2, 5),
  (3, 50),
  (4, 21), (4, 22), (4, 23), (4, 24), (4, 25),
  (5, 55);

COMMIT;
