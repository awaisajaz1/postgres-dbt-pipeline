{% set rating_list=['G', 'PG', 'PG-13', 'R', 'NC-17']%}

with rating_cte as (
    select
        rating,
        count(*) as rating_count
    from {{ ref('bronze_film') }}
    group by rating
)

{# Output from the CTE
rating   rating_count
------   ------------
PG-13    223
R        195
G        178
NC-17    210
PG       194
#}

{# Convert vertical output to horizontal #}

select
    'Total' as rating,
    {% for one_rate in rating_list %}
        sum(case when rating='{{ one_rate }}' then rating_count else 0 end) as "{{ one_rate }}"
        {% if not loop.last %},{% endif %}
    {% endfor %}
from rating_cte