{{ config(
    materialized = 'incremental', 
    unique_key = ['COACHID', 'YEAR']
) }}

WITH latest_data AS (
    SELECT
        *
    FROM {{ source('hockey_source', 'COACHES') }} 
)

SELECT *
FROM latest_data