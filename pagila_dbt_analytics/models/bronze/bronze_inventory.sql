{% set cols= dbt_utils.star(from=source('pagila_src', 'inventory')) %}
select
    {{cols}},
    CURRENT_TIMESTAMP::timestamp  as bronze_load_dts
from {{source('pagila_src', 'inventory')}}