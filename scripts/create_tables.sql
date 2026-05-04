BEGIN;

-- Criação das tabelas
CREATE TABLE IF NOT EXISTS public.permissoes_usuario
(
    id SERIAL PRIMARY KEY,
    super_usuario boolean,
    deletar_intervencao boolean,
    editar_intervencao boolean,
    criar_intervencao boolean,
    criar_grupo boolean,
    editar_grupo boolean,
    deletar_grupo boolean,
    criar_aluno boolean,
    visualizar_aluno boolean,
    visualizar_risco boolean
);

CREATE TABLE IF NOT EXISTS public.perfil
(
    id SERIAL PRIMARY KEY,
    id_permissao integer NOT NULL,
    nome character varying(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.instituicao
(
    cod_mec integer NOT NULL,
    nome character varying(50) NOT NULL,
    tipo character varying(20) NOT NULL,
    CONSTRAINT instituicao_pkey PRIMARY KEY (cod_mec)
);

CREATE TABLE IF NOT EXISTS public.unidade(
    id SERIAL PRIMARY KEY,
    id_instituicao integer,
    nome character varying(200) NOT NULL,
    sigla character varying(6) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.grupo
(
    id SERIAL PRIMARY KEY,
	id_usuario integer NOT NULL,
	titulo character varying(50) NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    observacao character varying(100),
    semestre character varying(6) NOT NULL,
    ativo boolean NOT NULL
);

CREATE TABLE IF NOT EXISTS public.usuario
(
    id SERIAL PRIMARY KEY,
    id_instituicao integer NOT NULL,
    id_perfil integer NOT NULL,
    nome character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    ultimo_acesso TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS public.curso
(
    id SERIAL PRIMARY KEY,
    id_instituicao integer,
    id_unidade integer,
	total_periodos integer,
    nome character varying(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.usuario_curso
(
    id_usuario integer,
    id_curso integer,
    CONSTRAINT id_usuario_curso PRIMARY KEY (id_usuario, id_curso)
);

CREATE TABLE IF NOT EXISTS public.disciplina
(
    id SERIAL PRIMARY KEY,
    id_curso integer NOT NULL,
    nome character varying(50) NOT NULL,
    carga_horaria integer NOT NULL
);

CREATE TABLE IF NOT EXISTS public.turma
(
    id SERIAL PRIMARY KEY,
    id_disciplina integer NOT NULL,
    nome character varying(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.estatisticas_desempenho
(
    id SERIAL PRIMARY KEY,
    maior_influencia_evasao character varying(100) NOT NULL,
    semestre_saida integer,
    risco NUMERIC(3, 2) CHECK (risco >= 0 AND risco <= 1)
);

CREATE TABLE IF NOT EXISTS public.estudante
(
    id SERIAL PRIMARY KEY,
    nome character varying(50) NOT NULL,
    email_institucional character varying(200) NOT NULL,
    cpf character varying(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.matricula
(
    id SERIAL PRIMARY KEY,
    id_curso integer NOT NULL,
    id_estudante integer NOT NULL,
    id_estatisticas_desempenho integer NOT NULL,
    matricula integer NOT NULL,
    media_global numeric(4, 2) NOT NULL,
    reprovacoes integer NOT NULL,
    data_ingresso date NOT NULL
);

CREATE TABLE IF NOT EXISTS public.matricula_grupo
(
    id_grupo integer NOT NULL,
    id_matricula integer NOT NULL,
    CONSTRAINT id_matricula_grupo PRIMARY KEY (id_matricula, id_grupo)
);

CREATE TABLE IF NOT EXISTS public.matricula_turma
(
    id_turma integer NOT NULL,
    id_matricula integer NOT NULL,
    CONSTRAINT id_matricula_turma PRIMARY KEY (id_matricula, id_turma)
);

CREATE TABLE IF NOT EXISTS public.intervencao
(
    id SERIAL PRIMARY KEY,
    id_usuario integer NOT NULL,
    id_disciplina integer,
	id_curso integer,
    data_intervencao TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    semestre character varying(6) NOT NULL,
    forma character varying(50) NOT NULL,
    formato text,
    interacao text,
    assunto character varying(50) NOT NULL,
    tipo character varying(20) NOT NULL CHECK (tipo IN ('Conteudo', 'Acolhimento', 'Outro')),
    acompanhamento character varying(10) NOT NULL CHECK (acompanhamento IN ('Assincrono', 'Sincrono')),
    objetivo_alcancado character varying(15) NOT NULL CHECK (objetivo_alcancado IN ('Sim', 'Nao', 'Parcialmente')),
    observacao text,
    duracao integer,
    encaminhar_para character varying(200)
);

CREATE TABLE IF NOT EXISTS public.matricula_intervencao
(
	id_matricula integer NOT NULL,
	id_intervencao integer NOT NULL,
	CONSTRAINT id_matricula_intervencao PRIMARY KEY (id_matricula, id_intervencao)
);

-- Definição das foreign keys
ALTER TABLE IF EXISTS public.usuario
    ADD CONSTRAINT usuario_id_perfil_fkey FOREIGN KEY (id_perfil)
    REFERENCES public.perfil (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.usuario
    ADD CONSTRAINT usuario_id_instituicao_fkey FOREIGN KEY (id_instituicao)
    REFERENCES public.instituicao (cod_mec) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.perfil
    ADD CONSTRAINT perfil_id_permissao_fkey FOREIGN KEY (id_permissao)
    REFERENCES public.permissoes_usuario (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.curso
    ADD CONSTRAINT curso_id_instituicao_fkey FOREIGN KEY (id_instituicao)
    REFERENCES public.instituicao (cod_mec) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.curso
    ADD CONSTRAINT curso_id_unidade_fkey FOREIGN KEY (id_unidade)
    REFERENCES public.unidade (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.unidade
    ADD CONSTRAINT unidade_id_instituicao_fkey FOREIGN KEY (id_instituicao)
    REFERENCES public.instituicao (cod_mec) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.disciplina
    ADD CONSTRAINT disciplina_id_curso_fkey FOREIGN KEY (id_curso)
    REFERENCES public.curso (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.usuario_curso
    ADD CONSTRAINT usuario_curso_id_usuario_fkey FOREIGN KEY (id_usuario)
    REFERENCES public.usuario (id)
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.usuario_curso
    ADD CONSTRAINT usuario_curso_id_curso_fkey FOREIGN KEY (id_curso)
    REFERENCES public.curso (id)
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.matricula
    ADD CONSTRAINT matricula_id_estatisticas_desempenho_fkey FOREIGN KEY (id_estatisticas_desempenho)
    REFERENCES public.estatisticas_desempenho (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.matricula
    ADD CONSTRAINT matricula_id_curso_fkey FOREIGN KEY (id_curso)
    REFERENCES public.curso (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.matricula
    ADD CONSTRAINT matricula_id_estudante_fkey FOREIGN KEY (id_estudante)
    REFERENCES public.estudante (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.matricula_grupo
    ADD CONSTRAINT matricula_grupo_id_matricula_fkey FOREIGN KEY (id_matricula)
    REFERENCES public.matricula (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.matricula_grupo
    ADD CONSTRAINT matricula_grupo_id_grupo_fkey FOREIGN KEY (id_grupo)
    REFERENCES public.grupo (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.matricula_turma
    ADD CONSTRAINT matricula_turma_id_matricula_fkey FOREIGN KEY (id_matricula)
    REFERENCES public.matricula (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.matricula_turma
    ADD CONSTRAINT matricula_turma_id_turma_fkey FOREIGN KEY (id_turma)
    REFERENCES public.turma (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.intervencao
    ADD CONSTRAINT intervencao_id_usuario_fkey FOREIGN KEY (id_usuario)
    REFERENCES public.usuario (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.intervencao
    ADD CONSTRAINT intervencao_id_disciplina_fkey FOREIGN KEY (id_disciplina)
    REFERENCES public.disciplina (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE SET NULL;

ALTER TABLE IF EXISTS public.intervencao
	ADD CONSTRAINT intervencao_id_curso_fkey FOREIGN KEY (id_curso)
	REFERENCES public.curso (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.matricula_intervencao
	ADD CONSTRAINT matricula_intervencao_id_matricula_fkey FOREIGN KEY (id_matricula)
	REFERENCES public.matricula (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.matricula_intervencao
	ADD CONSTRAINT matricula_intervencao_id_intervencao_fkey FOREIGN KEY (id_intervencao)
	REFERENCES public.intervencao (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.turma
    ADD CONSTRAINT turma_id_disciplina_fkey FOREIGN KEY (id_disciplina)
    REFERENCES public.disciplina (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.grupo
    ADD CONSTRAINT grupo_id_usuario_fkey FOREIGN KEY (id_usuario)
    REFERENCES public.usuario (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

END;
