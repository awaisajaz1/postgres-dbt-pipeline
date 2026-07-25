{{ config(
    materialized='incremental',
    unique_key='customer_id',
    incremental_strategy='merge'
) }}

with src as (

    select *
    from {{ ref('bronze_customer') }}

    {% if is_incremental() %}
    where last_update >
        (
            select coalesce(max(last_update),'1900-01-01')
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
    last_update
from dedup
where rn = 1