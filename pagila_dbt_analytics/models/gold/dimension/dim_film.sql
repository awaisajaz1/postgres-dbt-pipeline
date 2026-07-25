{{ config(
    materialized='incremental',
    unique_key='film_id',
    incremental_strategy='merge',
    on_schema_change='fail'
) }}

select

    {{ dbt_utils.generate_surrogate_key(['film_id']) }} as film_key,

    film_id,

    title,

    description,

    release_year,

    rental_rate,

    rating,

    last_update

from {{ ref('silver_film') }}