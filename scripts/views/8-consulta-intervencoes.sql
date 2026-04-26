-- Consulta de Intervenções de um curso
SELECT i.data_intervencao, i.formato, i.tipo, i.acompanhamento, i.observacao
FROM intervencao i
WHERE i.id_curso = 1
ORDER BY i.data_intervencao ASC;
