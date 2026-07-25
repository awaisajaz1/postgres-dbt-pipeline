select
    actor_id,
    first_name,
    last_name,
    last_update,
    CURRENT_TIMESTAMP::timestamp  as bronze_load_dts
from {{ source('pagila_src', 'actor') }}