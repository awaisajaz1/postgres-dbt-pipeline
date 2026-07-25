{{ config(
    materialized='table',
    contract={
        'enforced': true
    },
    post_hook=[
        "{{ update_watermark('bronze_load_dts') }}"
    ]
) }}

with src as (

    select
        rental_id,
        rental_date,
        inventory_id,
        customer_id,
        return_date,
        staff_id,
        last_update,
        bronze_load_dts
    from {{ ref('bronze_rental') }}

    where bronze_load_dts > {{ get_watermark(model.name) }}

),

dedup as (

    select
        *,
        row_number() over (
            partition by rental_id
            order by last_update desc, bronze_load_dts desc
        ) as rn
    from src

)

select
    rental_id,
    rental_date,
    inventory_id,
    customer_id,
    return_date,
    staff_id,
    last_update,
    bronze_load_dts
from dedup
where rn = 1