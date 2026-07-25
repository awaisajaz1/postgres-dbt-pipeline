{% macro start_batch() %}

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
    '{{ model.name }}',
    current_timestamp,
    'RUNNING',
    '{{ target.name }}',
    '{{ dbt_version }}',
    '{{ invocation_id }}'
);

{% endset %}

{% do run_query(sql) %}

{% endmacro %}