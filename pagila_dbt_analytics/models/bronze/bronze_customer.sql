{{ config(
    materialized='table',
    pre_hook="{{ start_batch() }}",
    post_hook="{{ end_batch() }}"
) }}

with customer_cte as (

    select
        *,
        row_number() over (
            partition by customer_id
            order by last_update desc
        ) as rn
    from {{ source('pagila_src', 'customer') }}

)

select
    customer_id,
    store_id,
    first_name,
    last_name,
    email,
    address_id,
    activebool,
    create_date,
    last_update,
    active,
    CURRENT_TIMESTAMP::timestamp  as bronze_load_dts
from customer_cte
where rn = 1