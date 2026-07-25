{% macro log_model_end() %}

{% set sql %}

{% set rows_sql = model.config.meta.get('rows_processed_sql') %}

update audit.etl_run_log
set
    finished_at = current_timestamp,

    status = 'SUCCESS',

    {# rows_processed =
    (
        select count(*)
        from {{ this }}
    ) #}
    {% if rows_sql %}
    rows_processed = (
        {{ rows_sql }}
    ),
    {% endif %}

    error_message = null

where
    batch_id =
    (
        select batch_id
        from audit.etl_batch
        where invocation_id='{{ invocation_id }}'
    )

and model_name='{{ model.name }}'

and status='RUNNING';

{% endset %}

{% do run_query(sql) %}

{% endmacro %}