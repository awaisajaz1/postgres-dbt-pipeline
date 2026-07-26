{% macro deploy_framework() %}

    {{ create_audit_schema() }}

    {{ create_etl_watermark() }}

    {{ create_etl_batch() }}

    {{ create_etl_run_log() }}

{% endmacro %}