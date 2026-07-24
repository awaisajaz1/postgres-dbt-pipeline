{% set my_name = "Owais" %}
{% set my_age = 32 %}
{% set is_weekend = false %}

select
    '{{ my_name }}' as name,
    {{ my_age }} as age,
    {% if is_weekend %}
        'Take a break!'
    {% else %}
        'Get to work!'
    {% endif %} as weekend_message