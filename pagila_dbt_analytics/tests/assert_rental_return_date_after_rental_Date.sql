select
    rental_id,
    rental_date,
    return_date
from {{ ref('bronze_rental') }}
where return_date < rental_date