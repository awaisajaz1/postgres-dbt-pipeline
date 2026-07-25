{% macro create_etl_pipeline() %}

{% set sql %}

create table if not exists audit.etl_pipeline
(
    pipeline_id        serial primary key,
    pipeline_name      varchar(100) unique,
    source_model       varchar(100),
    target_model       varchar(100),
    watermark_column   varchar(100),
    load_type          varchar(20),
    active_flag        boolean,
    created_at         timestamp,
    updated_at         timestamp
);

{% endset %}

{% do run_query(sql) %}

{% endmacro %}