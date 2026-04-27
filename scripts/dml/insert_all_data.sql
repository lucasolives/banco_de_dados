-- Permissões de usuário
INSERT INTO permissoes_usuario (id, super_usuario, deletar_intervencao, editar_intervencao, criar_intervencao, criar_grupo, editar_grupo, deletar_grupo, criar_aluno, visualizar_aluno, visualizar_risco)
VALUES (1, FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE), -- Coordenador de Curso
	   (2, FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE), -- Tutor
	   (3, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE) -- Coordenador de Ensino e Coordenador de Unidade
	   (4, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE); -- Público

-- Perfis
INSERT INTO perfil (id_permissao, nome)
VALUES (1, 'Coordenador de Curso'),
	   (2, 'Tutor'),
	   (3, 'Coordenador de Ensino'),
	   (3, 'Coordenador de Unidade'),
	   (4, 'Público');

-- Instituições
INSERT INTO instituicao (cod_mec, nome, tipo)
VALUES (1234, 'Universidade Federal de Goiás', 'Universidade Federal'),
	   (1235, 'Instituto Federal Goiano', 'Instituto Federal'),
	   (1236, 'Instituto Federal Catarinense', 'Instituto Federal'),
	   (1237, 'Universidade Federal de Tocantins', 'Universidade Federal'),
	   (1238, 'Universidade Federal de Santa Catarina', 'Universidade Federal');

-- Usuários
INSERT INTO usuario (id_instituicao, id_perfil, nome, email, ultimo_acesso)
VALUES (1, 1, 'Jose Roberto', 'jose_roberto@ufg.br', CURRENT_TIMESTAMP),
       (1, 2, 'Jose Antonio', 'jose_antonio@ufg.br', CURRENT_TIMESTAMP),
	   (1, 2, 'Otávio', 'otavio@ufg.br', CURRENT_TIMESTAMP),
	   (1, 3, 'João', 'joao@ufg.br', CURRENT_TIMESTAMP),
	   (1, 4, 'Eduardo', 'eduardo@ufg.br', CURRENT_TIMESTAMP),

	   (2, 1, 'Jose Roberto', 'jose_roberto@ifg.br', CURRENT_TIMESTAMP),
       (2, 2, 'Jose Antonio', 'jose_antonio@ifg.br', CURRENT_TIMESTAMP),
	   (2, 2, 'Otávio', 'otavio@ifg.br', CURRENT_TIMESTAMP),
	   (2, 3, 'João', 'joao@ifg.br', CURRENT_TIMESTAMP),
	   (2, 4, 'Eduardo', 'eduardo@ifg.br', CURRENT_TIMESTAMP),

	   (3, 1, 'Jose Roberto', 'jose_roberto@ifc.br', CURRENT_TIMESTAMP),
       (3, 2, 'Jose Antonio', 'jose_antonio@ifc.br', CURRENT_TIMESTAMP),
	   (3, 2, 'Otávio', 'otavio@ifc.br', CURRENT_TIMESTAMP),
	   (3, 3, 'João', 'joao@ifc.br', CURRENT_TIMESTAMP),
	   (3, 4, 'Eduardo', 'eduardo@ifc.br', CURRENT_TIMESTAMP),

	   (4, 1, 'Jose Roberto', 'jose_roberto@uft.br', CURRENT_TIMESTAMP),
       (4, 2, 'Jose Antonio', 'jose_antonio@uft.br', CURRENT_TIMESTAMP),
	   (4, 2, 'Otávio', 'otavio@uft.br', CURRENT_TIMESTAMP),
	   (4, 3, 'João', 'joao@uft.br', CURRENT_TIMESTAMP),
	   (4, 4, 'Eduardo', 'eduardo@uft.br', CURRENT_TIMESTAMP),

	   (5, 1, 'Jose Roberto', 'jose_roberto@ufsc.br', CURRENT_TIMESTAMP),
       (5, 2, 'Jose Antonio', 'jose_antonio@ufsc.br', CURRENT_TIMESTAMP),
	   (5, 2, 'Otávio', 'otavio@ufsc.br', CURRENT_TIMESTAMP),
	   (5, 3, 'João', 'joao@ufsc.br', CURRENT_TIMESTAMP),
	   (5, 4, 'Eduardo', 'eduardo@ufsc.br', CURRENT_TIMESTAMP);

-- Unidades
INSERT INTO unidade (id_instituicao, nome, sigla)
VALUES (1, 'Escola de Engenharia Elétrica, Mecânica e da Computação', 'EMC'),
	   (2, 'Escola de Engenharia Elétrica, Mecânica e da Computação', 'EMC'),
	   (3, 'Escola de Engenharia Elétrica, Mecânica e da Computação', 'EMC'),
	   (4, 'Escola de Engenharia Elétrica, Mecânica e da Computação', 'EMC'),
	   (5, 'Escola de Engenharia Elétrica, Mecânica e da Computação', 'EMC');

-- Cursos
INSERT INTO curso (id_instituicao, id_unidade, nome)
VALUES (1, 1, 'Engenharia Elétrica'),
	   (1, 1, 'Engenharia Mecânica'),
	   (1, 1, 'Engenharia de Computação'),
	   (1, 1, 'Engenharia Civil'),
	   (1, 1, 'Engenharia Mecatrônica'),

	   (2, 2, 'Engenharia Elétrica'),
	   (2, 2, 'Engenharia Mecânica'),
	   (2, 2, 'Engenharia de Computação'),
	   (2, 2, 'Engenharia Civil'),
	   (2, 2, 'Engenharia Mecatrônica'),

	   (3, 3, 'Engenharia Elétrica'),
	   (3, 3, 'Engenharia Mecânica'),
	   (3, 3, 'Engenharia de Computação'),
	   (3, 3, 'Engenharia Civil'),
	   (3, 3, 'Engenharia Mecatrônica'),

	   (4, 4, 'Engenharia Elétrica'),
	   (4, 4, 'Engenharia Mecânica'),
	   (4, 4, 'Engenharia de Computação'),
	   (4, 4, 'Engenharia Civil'),
	   (4, 4, 'Engenharia Mecatrônica'),

	   (5, 5, 'Engenharia Elétrica'),
	   (5, 5, 'Engenharia Mecânica'),
	   (5, 5, 'Engenharia de Computação'),
	   (5, 5, 'Engenharia Civil'),
	   (5, 5, 'Engenharia Mecatrônica');
