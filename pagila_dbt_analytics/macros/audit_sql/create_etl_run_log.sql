{% macro create_etl_run_log() %}

{% set sql %}

create table if not exists audit.etl_run_log
(
    run_log_id        bigserial primary key,
    batch_id          bigint,
    pipeline_name     varchar(100),
    layer_name        varchar(20),
    model_name        varchar(100),
    run_started_at    timestamp,
    run_finished_at   timestamp,
    status            varchar(20)
);


{% endset %}

{% do run_query(sql) %}

{% endmacro %}