{% macro deploy_framework() %}

    {{ create_schema() }}

    {{ create_etl_pipeline() }}

    {{ create_etl_watermark() }}

    {{ create_etl_batch() }}

    {{ create_etl_run_log() }}

    {{ create_etl_error_log() }}

    {{ create_etl_reject_log() }}

    {{ create_etl_data_quality() }}

{% endmacro %}