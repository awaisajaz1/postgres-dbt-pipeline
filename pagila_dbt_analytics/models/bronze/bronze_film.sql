{% set cols= dbt_utils.star(from=source('pagila_src', 'film')) %}
select
    {{cols}}
from {{source('pagila_src', 'film')}}