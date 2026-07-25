{{ config(
    materialized='incremental',
    unique_key='inventory_id',
    incremental_strategy='merge',
    on_schema_change='fail'
) }}

with src as (

    select *
    from {{ ref('bronze_inventory') }}

    {% if is_incremental() %}
    where bronze_load_dts >
        (
            select coalesce(max(bronze_load_dts),'1900-01-01')
            from {{ this }}
        )
    {% endif %}

),

dedup as (

    select
        *,
        row_number() over (
            partition by inventory_id
            order by last_update desc
        ) as rn
    from src

)

select
    inventory_id,
    film_id,
    store_id,
    last_update,
    bronze_load_dts
from dedup
where rn = 1