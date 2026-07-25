{% macro end_batch() %}

{% set sql %}

update audit.etl_batch

set

run_finished_at=current_timestamp,

status='SUCCESS'

where invocation_id='{{ invocation_id }}';

{% endset %}

{% do run_query(sql) %}

{% endmacro %}