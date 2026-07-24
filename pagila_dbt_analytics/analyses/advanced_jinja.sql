{% set rating_list=['G', 'PG', 'PG-13', 'R', 'NC-17']%}

with rating_cte as (
    select
        rating,
        count(*) as rating_count
    from {{ ref('bronze_film') }}
    group by rating
)

select * from rating_cte
{# \ output will be like #}
{# 
PG-13	223
R	195
G	178
NC-17	210
PG	194 
#}