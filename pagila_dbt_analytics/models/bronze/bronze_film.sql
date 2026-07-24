{% set cols= dbt_utils.star(
    from=source('pagila_src', 'film'),
      except=['rating', 'special_features']
) %}
select
    {{cols}},
    rating::text as rating,
    special_features::text as special_features
from {{source('pagila_src', 'film')}}