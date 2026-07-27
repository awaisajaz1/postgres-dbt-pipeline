{{ config(
    materialized='incremental',
    unique_key='customer_id',
    incremental_strategy='merge',
    on_schema_change='fail'
) }}

with src as (

    select *
    from {{ ref('silver_customer') }}

)


select

    {{ dbt_utils.generate_surrogate_key(['src.customer_id']) }} as customer_key,

    src.customer_id,
    full_name,
    email,
    address_id,
    activebool,
    create_date,
    last_update,
    cast(total_records as integer) as total_records

from src
left join {{ ref('eph_customer_act_records') }} as act
    on src.customer_id = act.customer_id