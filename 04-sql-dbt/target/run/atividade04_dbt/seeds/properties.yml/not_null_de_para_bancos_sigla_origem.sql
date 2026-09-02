
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select sigla_origem
from "database"."main"."de_para_bancos"
where sigla_origem is null



  
  
      
    ) dbt_internal_test