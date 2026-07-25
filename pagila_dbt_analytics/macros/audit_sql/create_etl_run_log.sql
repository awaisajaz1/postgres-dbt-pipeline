{% macro create_etl_run_log() %}

{% set sql %}

create table audit.etl_run_log
(
    run_log_id        bigserial primary key,
    batch_id          bigint not null,
    model_name        varchar(100) not null,
    layer_name        varchar(20),
    started_at        timestamp,
    finished_at       timestamp,
    status            varchar(20),
    rows_processed    bigint,
    error_message     text
);


{% endset %}

{% do run_query(sql) %}

{% endmacro %}