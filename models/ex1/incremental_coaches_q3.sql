{{ config(
    materialized = 'incremental', 
    unique_key = ['COACHID', 'YEAR','STINT']
) }}

SELECT * FROM {{ source('hockey_source', 'COACHES') }}
