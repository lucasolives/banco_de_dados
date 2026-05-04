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
INSERT INTO public.estudante (id, nome, email_institucional, cpf) VALUES
-- Curso 1 (Alunos 1 a 12)
(1, 'Estudante 1', 'estudante1@instituicao.edu.br', '00000000001'), (2, 'Estudante 2', 'estudante2@instituicao.edu.br', '00000000002'), (3, 'Estudante 3', 'estudante3@instituicao.edu.br', '00000000003'), (4, 'Estudante 4', 'estudante4@instituicao.edu.br', '00000000004'), (5, 'Estudante 5', 'estudante5@instituicao.edu.br', '00000000005'),
(6, 'Estudante 6', 'estudante6@instituicao.edu.br', '00000000006'), (7, 'Estudante 7', 'estudante7@instituicao.edu.br', '00000000007'), (8, 'Estudante 8', 'estudante8@instituicao.edu.br', '00000000008'), (9, 'Estudante 9', 'estudante9@instituicao.edu.br', '00000000009'), (10, 'Estudante 10', 'estudante10@instituicao.edu.br', '00000000010'),
(11, 'Estudante 11', 'estudante11@instituicao.edu.br', '00000000011'), (12, 'Estudante 12', 'estudante12@instituicao.edu.br', '00000000012'),
-- Curso 2 (Alunos 13 a 24)
(13, 'Estudante 13', 'estudante13@instituicao.edu.br', '00000000013'), (14, 'Estudante 14', 'estudante14@instituicao.edu.br', '00000000014'), (15, 'Estudante 15', 'estudante15@instituicao.edu.br', '00000000015'), (16, 'Estudante 16', 'estudante16@instituicao.edu.br', '00000000016'), (17, 'Estudante 17', 'estudante17@instituicao.edu.br', '00000000017'),
(18, 'Estudante 18', 'estudante18@instituicao.edu.br', '00000000018'), (19, 'Estudante 19', 'estudante19@instituicao.edu.br', '00000000019'), (20, 'Estudante 20', 'estudante20@instituicao.edu.br', '00000000020'), (21, 'Estudante 21', 'estudante21@instituicao.edu.br', '00000000021'), (22, 'Estudante 22', 'estudante22@instituicao.edu.br', '00000000022'),
(23, 'Estudante 23', 'estudante23@instituicao.edu.br', '00000000023'), (24, 'Estudante 24', 'estudante24@instituicao.edu.br', '00000000024'),
-- Curso 3 (Alunos 25 a 36)
(25, 'Estudante 25', 'estudante25@instituicao.edu.br', '00000000025'), (26, 'Estudante 26', 'estudante26@instituicao.edu.br', '00000000026'), (27, 'Estudante 27', 'estudante27@instituicao.edu.br', '00000000027'), (28, 'Estudante 28', 'estudante28@instituicao.edu.br', '00000000028'), (29, 'Estudante 29', 'estudante29@instituicao.edu.br', '00000000029'),
(30, 'Estudante 30', 'estudante30@instituicao.edu.br', '00000000030'), (31, 'Estudante 31', 'estudante31@instituicao.edu.br', '00000000031'), (32, 'Estudante 32', 'estudante32@instituicao.edu.br', '00000000032'), (33, 'Estudante 33', 'estudante33@instituicao.edu.br', '00000000033'), (34, 'Estudante 34', 'estudante34@instituicao.edu.br', '00000000034'),
(35, 'Estudante 35', 'estudante35@instituicao.edu.br', '00000000035'), (36, 'Estudante 36', 'estudante36@instituicao.edu.br', '00000000036'),
-- Curso 4 (Alunos 37 a 48)
(37, 'Estudante 37', 'estudante37@instituicao.edu.br', '00000000037'), (38, 'Estudante 38', 'estudante38@instituicao.edu.br', '00000000038'), (39, 'Estudante 39', 'estudante39@instituicao.edu.br', '00000000039'), (40, 'Estudante 40', 'estudante40@instituicao.edu.br', '00000000040'), (41, 'Estudante 41', 'estudante41@instituicao.edu.br', '00000000041'),
(42, 'Estudante 42', 'estudante42@instituicao.edu.br', '00000000042'), (43, 'Estudante 43', 'estudante43@instituicao.edu.br', '00000000043'), (44, 'Estudante 44', 'estudante44@instituicao.edu.br', '00000000044'), (45, 'Estudante 45', 'estudante45@instituicao.edu.br', '00000000045'), (46, 'Estudante 46', 'estudante46@instituicao.edu.br', '00000000046'),
(47, 'Estudante 47', 'estudante47@instituicao.edu.br', '00000000047'), (48, 'Estudante 48', 'estudante48@instituicao.edu.br', '00000000048'),
-- Curso 5 (Alunos 49 a 62)
(49, 'Estudante 49', 'estudante49@instituicao.edu.br', '00000000049'), (50, 'Estudante 50', 'estudante50@instituicao.edu.br', '00000000050'), (51, 'Estudante 51', 'estudante51@instituicao.edu.br', '00000000051'), (52, 'Estudante 52', 'estudante52@instituicao.edu.br', '00000000052'), (53, 'Estudante 53', 'estudante53@instituicao.edu.br', '00000000053'),
(54, 'Estudante 54', 'estudante54@instituicao.edu.br', '00000000054'), (55, 'Estudante 55', 'estudante55@instituicao.edu.br', '00000000055'), (56, 'Estudante 56', 'estudante56@instituicao.edu.br', '00000000056'), (57, 'Estudante 57', 'estudante57@instituicao.edu.br', '00000000057'), (58, 'Estudante 58', 'estudante58@instituicao.edu.br', '00000000058'),
(59, 'Estudante 59', 'estudante59@instituicao.edu.br', '00000000059'), (60, 'Estudante 60', 'estudante60@instituicao.edu.br', '00000000060'), (61, 'Estudante 61', 'estudante61@instituicao.edu.br', '00000000061'), (62, 'Estudante 62', 'estudante62@instituicao.edu.br', '00000000062'),
-- Curso 6 (Alunos 63 a 75)
(63, 'Estudante 63', 'estudante63@instituicao.edu.br', '00000000063'), (64, 'Estudante 64', 'estudante64@instituicao.edu.br', '00000000064'), (65, 'Estudante 65', 'estudante65@instituicao.edu.br', '00000000065'), (66, 'Estudante 66', 'estudante66@instituicao.edu.br', '00000000066'), (67, 'Estudante 67', 'estudante67@instituicao.edu.br', '00000000067'),
(68, 'Estudante 68', 'estudante68@instituicao.edu.br', '00000000068'), (69, 'Estudante 69', 'estudante69@instituicao.edu.br', '00000000069'), (70, 'Estudante 70', 'estudante70@instituicao.edu.br', '00000000070'), (71, 'Estudante 71', 'estudante71@instituicao.edu.br', '00000000071'), (72, 'Estudante 72', 'estudante72@instituicao.edu.br', '00000000072'),
(73, 'Estudante 73', 'estudante73@instituicao.edu.br', '00000000073'), (74, 'Estudante 74', 'estudante74@instituicao.edu.br', '00000000074'), (75, 'Estudante 75', 'estudante75@instituicao.edu.br', '00000000075'); -- Curso 1 (Alunos 1 a 12)
  
INSERT INTO public.estatisticas_desempenho (id, maior_influencia_evasao, semestre_saida, risco) VALUES
-- Curso 1 (Alunos 1 a 12)
(1, 'Nenhuma', 8, 0.05), (2, 'Financeiro', 9, 0.25), (3, 'Conteúdo', 10, 0.50), (4, 'Desmotivação', 8, 0.75), (5, 'Saúde/Trabalho', 9, 0.95),
(6, 'Nenhuma', 10, 0.05), (7, 'Financeiro', 8, 0.25), (8, 'Conteúdo', 9, 0.50), (9, 'Desmotivação', 10, 0.75), (10, 'Saúde/Trabalho', 8, 0.95),
(11, 'Nenhuma', 9, 0.05), (12, 'Financeiro', 10, 0.25),
-- Curso 2 (Alunos 13 a 24)
(13, 'Conteúdo', 8, 0.50), (14, 'Desmotivação', 9, 0.75), (15, 'Saúde/Trabalho', 10, 0.95), (16, 'Nenhuma', 8, 0.05), (17, 'Financeiro', 9, 0.25),
(18, 'Conteúdo', 10, 0.50), (19, 'Desmotivação', 8, 0.75), (20, 'Saúde/Trabalho', 9, 0.95), (21, 'Nenhuma', 10, 0.05), (22, 'Financeiro', 8, 0.25),
(23, 'Conteúdo', 9, 0.50), (24, 'Desmotivação', 10, 0.75),
-- Curso 3 (Alunos 25 a 36)
(25, 'Saúde/Trabalho', 8, 0.95), (26, 'Nenhuma', 9, 0.05), (27, 'Financeiro', 10, 0.25), (28, 'Conteúdo', 8, 0.50), (29, 'Desmotivação', 9, 0.75),
(30, 'Saúde/Trabalho', 10, 0.95), (31, 'Nenhuma', 8, 0.05), (32, 'Financeiro', 9, 0.25), (33, 'Conteúdo', 10, 0.50), (34, 'Desmotivação', 8, 0.75),
(35, 'Saúde/Trabalho', 9, 0.95), (36, 'Nenhuma', 10, 0.05),
-- Curso 4 (Alunos 37 a 48)
(37, 'Financeiro', 10, 0.25), (38, 'Conteúdo', 11, 0.50), (39, 'Desmotivação', 12, 0.75), (40, 'Saúde/Trabalho', 10, 0.95), (41, 'Nenhuma', 11, 0.05),
(42, 'Financeiro', 12, 0.25), (43, 'Conteúdo', 10, 0.50), (44, 'Desmotivação', 11, 0.75), (45, 'Saúde/Trabalho', 12, 0.95), (46, 'Nenhuma', 10, 0.05),
(47, 'Financeiro', 11, 0.25), (48, 'Conteúdo', 12, 0.50),
-- Curso 5 (Alunos 49 a 62)
(49, 'Desmotivação', 6, 0.75), (50, 'Saúde/Trabalho', 7, 0.95), (51, 'Nenhuma', 8, 0.05), (52, 'Financeiro', 6, 0.25), (53, 'Conteúdo', 7, 0.50),
(54, 'Desmotivação', 8, 0.75), (55, 'Saúde/Trabalho', 6, 0.95), (56, 'Nenhuma', 7, 0.05), (57, 'Financeiro', 8, 0.25), (58, 'Conteúdo', 6, 0.50),
(59, 'Desmotivação', 7, 0.75), (60, 'Saúde/Trabalho', 8, 0.95), (61, 'Nenhuma', 6, 0.05), (62, 'Financeiro', 7, 0.25),
-- Curso 6 (Alunos 63 a 75)
(63, 'Conteúdo', 8, 0.50), (64, 'Desmotivação', 6, 0.75), (65, 'Saúde/Trabalho', 7, 0.95), (66, 'Nenhuma', 8, 0.05), (67, 'Financeiro', 6, 0.25),
(68, 'Conteúdo', 7, 0.50), (69, 'Desmotivação', 8, 0.75), (70, 'Saúde/Trabalho', 6, 0.95), (71, 'Nenhuma', 7, 0.05), (72, 'Financeiro', 8, 0.25),
(73, 'Conteúdo', 6, 0.50), (74, 'Desmotivação', 7, 0.75), (75, 'Saúde/Trabalho', 8, 0.95);

INSERT INTO public.matricula (id, id_curso, id_estudante, id_estatisticas_desempenho, matricula, media_global, reprovacoes, data_ingresso) VALUES
-- Curso 1 (Alunos 1 a 12)
(1, 1, 1, 1, '202500001', 9.5, 0, '2025-02-01'), (2, 1, 2, 2, '202500002', 7.5, 1, '2025-02-01'), (3, 1, 3, 3, '202500003', 5.5, 3, '2025-02-01'), (4, 1, 4, 4, '202500004', 4.0, 4, '2025-02-01'), (5, 1, 5, 5, '202500005', 2.0, 6, '2025-02-01'),
(6, 1, 6, 6, '202500006', 9.5, 0, '2025-02-01'), (7, 1, 7, 7, '202500007', 7.5, 1, '2025-02-01'), (8, 1, 8, 8, '202500008', 5.5, 3, '2025-02-01'), (9, 1, 9, 9, '202500009', 4.0, 4, '2025-02-01'), (10, 1, 10, 10, '202500010', 2.0, 6, '2025-02-01'),
(11, 1, 11, 11, '202500011', 9.5, 0, '2025-02-01'), (12, 1, 12, 12, '202500012', 7.5, 1, '2025-02-01'),
-- Curso 2 (Alunos 13 a 24)
(13, 2, 13, 13, '202500013', 5.5, 3, '2025-03-01'), (14, 2, 14, 14, '202500014', 4.0, 4, '2025-03-01'), (15, 2, 15, 15, '202500015', 2.0, 6, '2025-03-01'), (16, 2, 16, 16, '202500016', 9.5, 0, '2025-03-01'), (17, 2, 17, 17, '202500017', 7.5, 1, '2025-03-01'),
(18, 2, 18, 18, '202500018', 5.5, 3, '2025-03-01'), (19, 2, 19, 19, '202500019', 4.0, 4, '2025-03-01'), (20, 2, 20, 20, '202500020', 2.0, 6, '2025-03-01'), (21, 2, 21, 21, '202500021', 9.5, 0, '2025-03-01'), (22, 2, 22, 22, '202500022', 7.5, 1, '2025-03-01'),
(23, 2, 23, 23, '202500023', 5.5, 3, '2025-03-01'), (24, 2, 24, 24, '202500024', 4.0, 4, '2025-03-01'),
-- Curso 3 (Alunos 25 a 36)
(25, 3, 25, 25, '202500025', 2.0, 6, '2025-04-01'), (26, 3, 26, 26, '202500026', 9.5, 0, '2025-04-01'), (27, 3, 27, 27, '202500027', 7.5, 1, '2025-04-01'), (28, 3, 28, 28, '202500028', 5.5, 3, '2025-04-01'), (29, 3, 29, 29, '202500029', 4.0, 4, '2025-04-01'),
(30, 3, 30, 30, '202500030', 2.0, 6, '2025-04-01'), (31, 3, 31, 31, '202500031', 9.5, 0, '2025-04-01'), (32, 3, 32, 32, '202500032', 7.5, 1, '2025-04-01'), (33, 3, 33, 33, '202500033', 5.5, 3, '2025-04-01'), (34, 3, 34, 34, '202500034', 4.0, 4, '2025-04-01'),
(35, 3, 35, 35, '202500035', 2.0, 6, '2025-04-01'), (36, 3, 36, 36, '202500036', 9.5, 0, '2025-04-01'),
-- Curso 4 (Alunos 37 a 48)
(37, 4, 37, 37, '202500037', 7.5, 1, '2025-05-01'), (38, 4, 38, 38, '202500038', 5.5, 3, '2025-05-01'), (39, 4, 39, 39, '202500039', 4.0, 4, '2025-05-01'), (40, 4, 40, 40, '202500040', 2.0, 6, '2025-05-01'), (41, 4, 41, 41, '202500041', 9.5, 0, '2025-05-01'),
(42, 4, 42, 42, '202500042', 7.5, 1, '2025-05-01'), (43, 4, 43, 43, '202500043', 5.5, 3, '2025-05-01'), (44, 4, 44, 44, '202500044', 4.0, 4, '2025-05-01'), (45, 4, 45, 45, '202500045', 2.0, 6, '2025-05-01'), (46, 4, 46, 46, '202500046', 9.5, 0, '2025-05-01'),
(47, 4, 47, 47, '202500047', 7.5, 1, '2025-05-01'), (48, 4, 48, 48, '202500048', 5.5, 3, '2025-05-01'),
-- Curso 5 (Alunos 49 a 62)
(49, 5, 49, 49, '202500049', 4.0, 4, '2025-06-01'), (50, 5, 50, 50, '202500050', 2.0, 6, '2025-06-01'), (51, 5, 51, 51, '202500051', 9.5, 0, '2025-06-01'), (52, 5, 52, 52, '202500052', 7.5, 1, '2025-06-01'), (53, 5, 53, 53, '202500053', 5.5, 3, '2025-06-01'),
(54, 5, 54, 54, '202500054', 4.0, 4, '2025-06-01'), (55, 5, 55, 55, '202500055', 2.0, 6, '2025-06-01'), (56, 5, 56, 56, '202500056', 9.5, 0, '2025-06-01'), (57, 5, 57, 57, '202500057', 7.5, 1, '2025-06-01'), (58, 5, 58, 58, '202500058', 5.5, 3, '2025-06-01'),
(59, 5, 59, 59, '202500059', 4.0, 4, '2025-06-01'), (60, 5, 60, 60, '202500060', 2.0, 6, '2025-06-01'), (61, 5, 61, 61, '202500061', 9.5, 0, '2025-06-01'), (62, 5, 62, 62, '202500062', 7.5, 1, '2025-06-01'),
-- Curso 6 (Alunos 63 a 75)
(63, 6, 63, 63, '202500063', 5.5, 3, '2025-07-01'), (64, 6, 64, 64, '202500064', 4.0, 4, '2025-07-01'), (65, 6, 65, 65, '202500065', 2.0, 6, '2025-07-01'), (66, 6, 66, 66, '202500066', 9.5, 0, '2025-07-01'), (67, 6, 67, 67, '202500067', 7.5, 1, '2025-07-01'),
(68, 6, 68, 68, '202500068', 5.5, 3, '2025-07-01'), (69, 6, 69, 69, '202500069', 4.0, 4, '2025-07-01'), (70, 6, 70, 70, '202500070', 2.0, 6, '2025-07-01'), (71, 6, 71, 71, '202500071', 9.5, 0, '2025-07-01'), (72, 6, 72, 72, '202500072', 7.5, 1, '2025-07-01'),
(73, 6, 73, 73, '202500073', 5.5, 3, '2025-07-01'), (74, 6, 74, 74, '202500074', 4.0, 4, '2025-07-01'), (75, 6, 75, 75, '202500075', 2.0, 6, '2025-07-01');

INSERT INTO public.matricula_turma (id_matricula, id_turma) VALUES
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
-- 7. grupos / N:N estudante_grupo
-- ============================================================
INSERT INTO public.grupo (id, id_usuario, titulo, semestre, ativo, observacao) VALUES
  (1, 2, 'Monitoria de Lógica', '2026.1', true, 'Apoio extra-classe'),
  (2, 1, 'Iniciação Científica', '2026.1', true, 'Pesquisa Avançada'),
  (3, 2, 'Apoio em Estrutura de Dados', '2026.1', true, 'Foco prático'),
  (4, 1, 'Saúde Mental no Campus', '2026.1', true, 'Roda de conversa'),
  (5, 3, 'Nivelamento de Cálculo', '2026.1', true, 'Revisão matemática básica');

INSERT INTO public.matricula_grupo (id_grupo, id_matricula) VALUES
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

INSERT INTO public.matricula_intervencao (id_intervencao, id_matricula) VALUES
  (1, 30),
  (2, 1), (2, 2), (2, 3), (2, 4), (2, 5),
  (3, 50),
  (4, 21), (4, 22), (4, 23), (4, 24), (4, 25),
  (5, 55);

COMMIT;
