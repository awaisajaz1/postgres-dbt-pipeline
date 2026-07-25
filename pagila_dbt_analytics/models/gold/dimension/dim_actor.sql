{{ config(
    materialized='incremental',
    unique_key='actor_id',
    incremental_strategy='merge',
    on_schema_change='fail'
) }}

select

    {{ dbt_utils.generate_surrogate_key(['actor_id']) }} as actor_key,

    actor_id,

    actor_name,

    last_update

from {{ ref('silver_actors') }}