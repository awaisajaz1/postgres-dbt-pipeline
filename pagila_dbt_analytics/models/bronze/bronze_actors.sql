{# {{ log("Model: " ~ this.identifier, info=True) }}
{{ log("Invocation: " ~ invocation_id, info=True) }} #}

{{ config(
    materialized='table',
    pre_hook="{{ start_batch() }}",
    post_hook="{{ end_batch() }}"
) }}


select
    actor_id,
    first_name,
    last_name,
    last_update,
    CURRENT_TIMESTAMP::timestamp  as bronze_load_dts
from {{ source('pagila_src', 'actor') }}