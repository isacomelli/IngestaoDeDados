
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select nome_norm
from "database"."delivery"."bancos_indicadores"
where nome_norm is null



  
  
      
    ) dbt_internal_test