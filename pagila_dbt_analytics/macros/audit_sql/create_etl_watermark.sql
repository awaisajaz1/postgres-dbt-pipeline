{% macro create_etl_watermark() %}

{% set sql %}

create table if not exists audit.etl_watermark
(
    watermark_id      bigserial primary key,
    model_name        varchar(100) not null unique,
    layer_name        varchar(20) not null,
    watermark_column  varchar(100) not null,
    last_watermark    timestamp not null,
    updated_at        timestamp not null default current_timestamp,
    batch_id          bigint
);


{% endset %}

{% do run_query(sql) %}

{% endmacro %}