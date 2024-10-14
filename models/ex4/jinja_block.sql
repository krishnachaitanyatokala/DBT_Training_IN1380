{{ config(
    materialized = 'view'
) }}

WITH filtered_data AS (
    SELECT *
    FROM {{ source('hockey_source', 'COACHES') }}
    {% if var('filter_year') %}
        WHERE YEAR = {{ var('filter_year') }}
    {% endif %}
)

SELECT *
FROM filtered_data
