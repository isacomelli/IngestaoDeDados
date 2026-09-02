
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  -- Garante que o total de reclamações não seja negativo
SELECT
    nome,
    reclamacao_total
FROM "database"."delivery"."bancos_indicadores"
WHERE reclamacao_total < 0
  
  
      
    ) dbt_internal_test