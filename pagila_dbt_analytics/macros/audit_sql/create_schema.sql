{% macro create_schema() %}

    {% do run_query("create schema if not exists audit") %}

{% endmacro %}