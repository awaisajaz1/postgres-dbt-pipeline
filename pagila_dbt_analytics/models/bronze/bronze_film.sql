{% set cols= dbt_utils.star(
    from=source('pagila_src', 'film'),
      except=['rating', 'special_features']
) %}
select
    {{cols}},
    rating::text as rating,
    special_features::text as special_features,
    CURRENT_TIMESTAMP::timestamp  as bronze_load_dts
from {{source('pagila_src', 'film')}}