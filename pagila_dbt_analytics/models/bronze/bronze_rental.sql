{{ config(
    materialized='table',
    pre_hook="{{ start_batch() }}",
    post_hook="{{ end_batch() }}"
) }}

{% set cols= dbt_utils.star(from=source('pagila_src', 'rental')) %}
select
    {{cols}},
    CURRENT_TIMESTAMP::timestamp  as bronze_load_dts
from {{source('pagila_src', 'rental')}}