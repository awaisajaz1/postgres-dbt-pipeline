{% set cols= dbt_utils.star(from=source('pagila_src', 'inventory')) %}
select
    {{cols}}
from {{source('pagila_src', 'inventory')}}