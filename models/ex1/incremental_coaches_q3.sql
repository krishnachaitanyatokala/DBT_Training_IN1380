{{ config(
    materialized = 'incremental', 
    unique_key = ['COACHID', 'YEAR']
) }}

SELECT * FROM {{ source('hockey_source', 'COACHES') }}
