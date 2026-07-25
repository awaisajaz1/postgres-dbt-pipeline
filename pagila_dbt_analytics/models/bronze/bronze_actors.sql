select
    actor_id,
    first_name,
    last_name,
    last_update,
    current_timestamp() as bronze_loaded_at
from {{ source('pagila_src', 'actor') }}