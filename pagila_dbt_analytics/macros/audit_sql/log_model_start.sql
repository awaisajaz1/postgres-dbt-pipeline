{% macro log_model_start() %}

{% set sql %}

insert into audit.etl_run_log
(
    batch_id,
    model_name,
    layer_name,
    started_at,
    status
)

select
    batch_id,
    '{{ model.name }}',
    split_part('{{ model.name }}','_',1),
    current_timestamp,
    'RUNNING'

from audit.etl_batch

where invocation_id='{{ invocation_id }}';

{% endset %}

{% do run_query(sql) %}

{% endmacro %}