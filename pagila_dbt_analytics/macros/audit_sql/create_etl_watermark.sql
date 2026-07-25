{% macro create_etl_watermark() %}

{% set sql %}

create table if not exists audit.etl_watermark
(
    pipeline_name          varchar(100) primary key,
    last_success_dts       timestamp,
    current_watermark_dts  timestamp,
    previous_watermark_dts timestamp,
    status                 varchar(20),
    updated_at             timestamp
);


{% endset %}

{% do run_query(sql) %}

{% endmacro %}