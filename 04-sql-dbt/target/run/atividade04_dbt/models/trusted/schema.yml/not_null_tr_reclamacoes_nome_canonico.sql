
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select nome_canonico
from "database"."trusted"."tr_reclamacoes"
where nome_canonico is null



  
  
      
    ) dbt_internal_test