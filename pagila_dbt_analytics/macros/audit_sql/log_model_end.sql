{% macro log_model_end() %}

{% set sql %}

update audit.etl_run_log
set
    finished_at = current_timestamp,
    status = 'SUCCESS'
where
    batch_id = (
        select batch_id
        from audit.etl_batch
        where invocation_id = '{{ invocation_id }}'
    )
    and model_name = '{{ model.name }}'
    and status = 'RUNNING';

{% endset %}

{% do run_query(sql) %}

{% endmacro %}