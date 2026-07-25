{{ config(
    materialized='incremental',
    unique_key='customer_id',
    incremental_strategy='merge',
    on_schema_change='fail'
) }}

with src as (

    select *
    from {{ ref('bronze_customer') }}

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
            partition by customer_id
            order by last_update desc
        ) as rn
    from src

)

select
    customer_id,
    first_name || ' ' || last_name as full_name,
    email,
    address_id,
    activebool,
    create_date,
    last_update,
    bronze_load_dts
from dedup
where rn = 1