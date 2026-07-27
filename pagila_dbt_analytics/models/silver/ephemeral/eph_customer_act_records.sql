{{
config(
    materialized='ephemeral'
)
}}

with customers as (
    select *
    from {{ ref('silver_customer') }}
)

select customer_id, count(1) as total_records
from customers
where activebool = true
group by customer_id