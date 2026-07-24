{% set cols= dbt_utils.star(from=source('pagila_src', 'rental')) %}
select
    {{cols}}
from {{source('pagila_src', 'rental')}}