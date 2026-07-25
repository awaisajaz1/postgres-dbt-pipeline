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

    {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_key,

    customer_id,

    full_name,

    email,

    address_id,

    activebool,

    create_date,

    last_update

from src