{% set cols= dbt_utils.star(from=source('pagila_src', 'rental')) %}
select
    {{cols}},
    current_timestamp() as bronze_loaded_at
from {{source('pagila_src', 'rental')}}