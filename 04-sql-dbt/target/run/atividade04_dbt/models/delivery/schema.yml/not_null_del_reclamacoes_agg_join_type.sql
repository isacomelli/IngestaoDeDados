
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select join_type
from "database"."delivery"."del_reclamacoes_agg"
where join_type is null



  
  
      
    ) dbt_internal_test