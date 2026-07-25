{% macro update_watermark() %}

{% set sql %}

update audit.etl_watermark
set
    last_watermark =
    (
        select max(bronze_load_dts)
        from {{ this }}
    ),

    updated_at = current_timestamp,

    batch_id =
    (
        select batch_id
        from audit.etl_batch
        where invocation_id = '{{ invocation_id }}'
    )

where model_name = '{{ model.name }}';

{% endset %}

{% do run_query(sql) %}

{% endmacro %}