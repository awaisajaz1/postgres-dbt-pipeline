{% macro start_batch() %}

{% set sql %}

insert into audit.etl_batch
(
    invocation_id,
    run_started_at,
    status,
    environment,
    dbt_version
)
values
(
    '{{ invocation_id }}',
    current_timestamp,
    'RUNNING',
    '{{ target.name }}',
    '{{ dbt_version }}'
);

{% endset %}

{% do run_query(sql) %}

{% endmacro %}