-- Garante que o total de reclamações não seja negativo
SELECT
    nome,
    reclamacao_total
FROM "database"."delivery"."bancos_indicadores"
WHERE reclamacao_total < 0