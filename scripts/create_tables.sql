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
    id_estudante integer NOT NULL UNIQUE, 
    media_global numeric(4, 2) NOT NULL,
    semestre integer NOT NULL,
    reprovacoes integer NOT NULL,
    ch_semestre integer NOT NULL,
    turmas integer NOT NULL,
    maior_influencia_evasao character varying(100) NOT NULL,
    semestre_saida integer,
    risco NUMERIC(3, 2) CHECK (risco >= 0 AND risco <= 1)
);

CREATE TABLE IF NOT EXISTS public.estudante
(
    id SERIAL PRIMARY KEY,
    id_instituicao integer NOT NULL,
    id_curso integer NOT NULL,
    matricula integer NOT NULL,
    nome character varying(50) NOT NULL,
    data_ingresso date NOT NULL,
    UNIQUE (id_instituicao, matricula)
);

CREATE TABLE IF NOT EXISTS public.estudante_grupo
(
    id_grupo integer NOT NULL,
    id_estudante integer NOT NULL,
    CONSTRAINT id_estudante_grupo PRIMARY KEY (id_estudante, id_grupo)
);

CREATE TABLE IF NOT EXISTS public.estudante_turma
(
    id_turma integer NOT NULL,
    id_estudante integer NOT NULL,
    CONSTRAINT id_estudante_turma PRIMARY KEY (id_estudante, id_turma)
);

CREATE TABLE IF NOT EXISTS public.intervencao
(
    id SERIAL PRIMARY KEY,
    id_usuario integer NOT NULL,
    data_intervencao TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    semestre character varying(6) NOT NULL,
    forma character varying(50) NOT NULL,
    formato text,
    interacao text,
    assunto character varying(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.estudante_intervencao
(
	id_estudante integer NOT NULL,
	id_intervencao integer NOT NULL,
	CONSTRAINT id_estudante_intervencao PRIMARY KEY (id_estudante, id_intervencao)
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

ALTER TABLE IF EXISTS public.estatisticas_desempenho
    ADD CONSTRAINT estatisticas_desempenho_id_estudante_fkey FOREIGN KEY (id_estudante)
    REFERENCES public.estudante (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.estudante
    ADD CONSTRAINT estudante_id_instituicao_fkey FOREIGN KEY (id_instituicao)
    REFERENCES public.instituicao (cod_mec) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.estudante
    ADD CONSTRAINT estudante_id_curso_fkey FOREIGN KEY (id_curso)
    REFERENCES public.curso (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.estudante_grupo
    ADD CONSTRAINT estudante_grupo_id_estudante_fkey FOREIGN KEY (id_estudante)
    REFERENCES public.estudante (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.estudante_grupo
    ADD CONSTRAINT estudante_grupo_id_grupo_fkey FOREIGN KEY (id_grupo)
    REFERENCES public.grupo (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.estudante_turma
    ADD CONSTRAINT estudante_turma_id_estudante_fkey FOREIGN KEY (id_estudante)
    REFERENCES public.estudante (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.estudante_turma
    ADD CONSTRAINT estudante_turma_id_turma_fkey FOREIGN KEY (id_turma)
    REFERENCES public.turma (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.intervencao
    ADD CONSTRAINT intervencao_id_usuario_fkey FOREIGN KEY (id_usuario)
    REFERENCES public.usuario (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.estudante_intervencao
	ADD CONSTRAINT estudante_intervencao_id_estudante_fkey FOREIGN KEY (id_estudante)
	REFERENCES public.estudante (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE CASCADE;

ALTER TABLE IF EXISTS public.estudante_intervencao
	ADD CONSTRAINT estudante_intervencao_id_intervencao_fkey FOREIGN KEY (id_intervencao)
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
