{{ config(
    materialized='incremental',
    unique_key='film_id',
    incremental_strategy='merge',
    on_schema_change='fail'
) }}

with src as (

    select *
    from {{ ref('bronze_film') }}

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
            partition by film_id
            order by last_update desc
        ) as rn
    from src

)

select
    film_id,
    title,
    description,
    release_year,
    rental_rate,
    rating,
    last_update,
    bronze_load_dts
from dedup
where rn = 1