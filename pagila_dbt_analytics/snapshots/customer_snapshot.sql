{% snapshot customer_snapshot %}

{{

    config(
        target_schema='gold',
        unique_key='customer_id',
        strategy='timestamp',
        updated_at='last_update'
    )

}}

select *
from {{ ref('silver_customer') }}

{% endsnapshot %}