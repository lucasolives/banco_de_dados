-- Consulta de Intervenções de um curso
SELECT i.data_intervencao, i.formato, i.tipo, i.acompanhamento, i.observacao
FROM intervencao i
ORDER BY i.data_intervencao ASC;
