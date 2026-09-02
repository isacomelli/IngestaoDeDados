
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  -- Garante que não existem bancos duplicados na tabela final delivery
SELECT
    COALESCE(NULLIF(cnpj_norm, ''), nome_norm) AS chave,
    COUNT(*) AS total
FROM "database"."delivery"."bancos_indicadores"
GROUP BY 1
HAVING COUNT(*) > 1
  
  
      
    ) dbt_internal_test