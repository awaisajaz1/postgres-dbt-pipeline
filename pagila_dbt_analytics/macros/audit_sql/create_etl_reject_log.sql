{% macro create_etl_reject_log() %}

{% set sql %}

create table if not exists audit.etl_reject_log
(
    reject_id          bigserial primary key,
    batch_id           bigint,
    model_name         varchar(100),
    business_key       varchar(200),
    reason             text,
    rejected_at        timestamp
);

{% endset %}

{% do run_query(sql) %}

{% endmacro %}