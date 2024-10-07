{{ config(materialized='view') }}

SELECT *
FROM {{ source('hockey_source', 'TEAMS') }}
