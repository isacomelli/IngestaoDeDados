
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select nome_norm
from "database"."trusted"."tr_bancos"
where nome_norm is null



  
  
      
    ) dbt_internal_test