{% macro start_batch(model_name) %}

{% set sql %}

insert into audit.etl_batch
(
    pipeline_name,
    run_started_at,
    status,
    environment,
    dbt_version,
    invocation_id
)
values
(
    '{{ model_name }}',
    current_timestamp,
    'RUNNING',
    '{{ target.name }}',
    '{{ dbt_version }}',
    '{{ invocation_id }}'
);

{% endset %}

{% do run_query(sql) %}

{% endmacro %}