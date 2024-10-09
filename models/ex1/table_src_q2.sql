{{ config(materialized='table')}}

SELECT *
FROM {{ source('hockey_source', 'SCORING') }}
