{{ config(
    materialized='incremental',
    unique_key='customer_id'
) }}