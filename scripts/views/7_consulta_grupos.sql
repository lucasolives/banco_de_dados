----------
-- Lista Grupos
----------

SELECT
    g.titulo,
    g.semestre,
    COUNT(DISTINCT mg.id_matricula) AS estudantes,
    TO_CHAR(g.data_criacao, 'DD/MM/YYYY') AS criacao,
    g.observacao,
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
    LEFT JOIN matricula_grupo mg ON g.id = mg.id_grupo
GROUP BY 
    g.id, 
	g.titulo, 
	g.semestre, 
	g.data_criacao, 
	g.observacao, 
	u.id, 
	p.nome, 
	g.ativo;
    
---------
-- Registro de nova intervenção
---------

-- Nome e matrícula dos estudantes do Grupo selecionado
SELECT
    e.nome,
    m.matricula
FROM public.matricula_grupo mg
    INNER JOIN public.matricula m ON mg.id_matricula = m.id
    INNER JOIN public.estudante e ON m.id_estudante = e.id
WHERE mg.id_grupo = 1;

-- Criação da intervenção
INSERT INTO public.intervencao (id, id_usuario, id_disciplina, id_curso, semestre, forma, formato, interacao, assunto, tipo, acompanhamento, objetivo_alcancado, duracao) 
VALUES (6, 2, 1, 1, '2026.1', 'Chat Online', 'grupo', 'reativa', 'Dúvidas Arquitetura', 'Conteudo', 'Assincrono', 'Sim', 15);

INSERT INTO public.matricula_intervencao (id_intervencao, id_matricula) 
VALUES (6, 1), (6, 2);

-- Visualizar Intervenção criada
SELECT
    STRING_AGG(e.nome || ' - ' || m.matricula, ', ') AS estudantes,
    i.data_intervencao as "Data",
    i.semestre as "Semestre",
    d.nome as "Disciplina",
    i.assunto AS "Assunto",
    i.forma AS "Forma",
    i.formato AS "Formato",
    i.interacao AS "Interação",
    i.tipo AS "Tipo",
    i.acompanhamento AS "Acompanhamento",
    i.duracao AS "Duração",
    i.objetivo_alcancado AS "Objetivo alcançado"
FROM intervencao i
    INNER JOIN matricula_intervencao mi ON i.id = mi.id_intervencao
    INNER JOIN matricula m ON mi.id_matricula = m.id
    INNER JOIN estudante e ON m.id_estudante = e.id
    INNER JOIN disciplina d ON i.id_disciplina = d.id
WHERE i.id = 6;
