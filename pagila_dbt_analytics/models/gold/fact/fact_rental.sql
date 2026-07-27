{{ config(
    materialized='incremental',
    unique_key='rental_id',
    incremental_strategy='merge',
    on_schema_change='fail'
) }}

with rental as (

    select *
    from {{ ref('silver_rental') }}

),

dim_customer as (

    select
        customer_key,
        customer_id
    from {{ ref('dim_customer') }}

),

dim_film as (

    select
        film_key,
        film_id
    from {{ ref('dim_film') }}

),

inventory as (

    select
        inventory_id,
        film_id,
        store_id
    from {{ ref('silver_inventory') }}

),
customer_scd as (

    select *
    from {{ ref('customer_snapshot') }}

)

select

    {{ dbt_utils.generate_surrogate_key(['r.rental_id']) }} as rental_key,
    r.rental_id,
    dc.customer_key,
    cs.dbt_scd_id as customer_scd_id,
    df.film_key,
    r.inventory_id,
    r.rental_date,
    r.return_date,

    extract(day from (r.return_date - r.rental_date))
        as rental_duration_days,

    1 as rental_count,

    r.last_update,
    r.bronze_load_dts

from rental r

join inventory i
    on r.inventory_id = i.inventory_id

join dim_customer dc
    on r.customer_id = dc.customer_id

join dim_film df
    on i.film_id = df.film_id

join customer_scd cs
    on r.customer_id = cs.customer_id
    and cs.dbt_valid_to is null