{% macro end_batch() %}

{{ log("END BATCH EXECUTED", info=True) }}

{% set sql %}

update audit.etl_batch
set
    run_finished_at = current_timestamp,
    status = 'SUCCESS'
where
    pipeline_name = '{{ this.identifier }}';

{% endset %}

{{ log(sql, info=True) }}

{% do run_query(sql) %}

{% endmacro %}