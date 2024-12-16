SELECT f.nome AS fazenda, COUNT(c.id) AS total_colaboradores
FROM colaborador c
JOIN fazenda f ON c.fazenda_id = f.id
GROUP BY f.nome;
