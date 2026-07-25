{% macro create_etl_error_log() %}

{% set sql %}

create table if not exists audit.etl_error_log
(
    error_id          bigserial primary key,
    batch_id          bigint,
    model_name        varchar(100),
    error_timestamp   timestamp,
    error_message     text,
    sql_state         varchar(20),
    stack_trace       text
);

{% endset %}

{% do run_query(sql) %}

{% endmacro %}