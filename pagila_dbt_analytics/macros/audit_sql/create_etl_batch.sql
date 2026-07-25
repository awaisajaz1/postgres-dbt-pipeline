{% macro create_etl_batch() %}

{% set sql %}

create table if not exists audit.etl_batch
(
    batch_id          bigserial primary key,
    invocation_id     varchar(100) unique,
    run_started_at    timestamp,
    run_finished_at   timestamp,
    status            varchar(20),
    environment       varchar(20),
    dbt_version       varchar(20)
);

{% endset %}

{% do run_query(sql) %}

{% endmacro %}