{% macro get_watermark(model_name) %}

(
    select
        coalesce(max(last_watermark), '1900-01-01'::timestamp)
    from audit.etl_watermark
    where model_name = '{{ model_name }}'
)

{% endmacro %}