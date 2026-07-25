{% macro update_watermark(watermark_column) %}

{% if execute %}

    {% set max_sql %}

        select max({{ watermark_column }})
        from {{ this }}

    {% endset %}

    {% set max_result = run_query(max_sql) %}
    {% set max_watermark = max_result.columns[0].values()[0] %}

    {% if max_watermark is not none %}

        {% set check_sql %}

            select count(*)
            from audit.etl_watermark
            where model_name = '{{ model.name }}'

        {% endset %}

        {% set result = run_query(check_sql) %}
        {% set row_exists = result.columns[0].values()[0] | int %}

        {% if row_exists == 0 %}

            {% set sql %}

            insert into audit.etl_watermark
            (
                model_name,
                layer_name,
                watermark_column,
                last_watermark,
                updated_at,
                batch_id
            )
            values
            (
                '{{ model.name }}',
                '{{ model.name.split("_")[0] }}',
                '{{ watermark_column }}',
                '{{ max_watermark }}',
                current_timestamp,
                (
                    select batch_id
                    from audit.etl_batch
                    where invocation_id = '{{ invocation_id }}'
                )
            );

            {% endset %}

        {% else %}

            {% set sql %}

            update audit.etl_watermark
            set
                last_watermark = '{{ max_watermark }}',
                updated_at = current_timestamp,
                batch_id =
                (
                    select batch_id
                    from audit.etl_batch
                    where invocation_id = '{{ invocation_id }}'
                )

            where model_name = '{{ model.name }}';

            {% endset %}

        {% endif %}

        {% do run_query(sql) %}

    {% else %}

        {{ log("No new records found. Watermark not updated for " ~ model.name, info=True) }}

    {% endif %}

{% endif %}

{% endmacro %}