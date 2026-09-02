
    
    

select
    sigla_origem as unique_field,
    count(*) as n_records

from "database"."main"."de_para_bancos"
where sigla_origem is not null
group by sigla_origem
having count(*) > 1


