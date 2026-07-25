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
select
    '{{ invocation_id }}',
    current_timestamp,
    'RUNNING',
    '{{ target.name }}',
    '{{ dbt_version }}'
where not exists
(
    select 1
    from audit.etl_batch
    where invocation_id='{{ invocation_id }}'
);

{% endset %}

{% do run_query(sql) %}

{% endmacro %}