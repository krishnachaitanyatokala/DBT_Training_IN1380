

{{ config(
    materialized='table'  
) }}

WITH raw_data AS (
    SELECT
        COALESCE(PLAYERID, '') AS PLAYERID,
        COALESCE(AWARD, '') AS AWARD,
        COALESCE(YEAR, 0) AS YEAR,
        COALESCE(LGID, '') AS LGID,
        COALESCE(NOTE, '') AS NOTE,
        COALESCE(POS, '') AS POS
    FROM 
        {{ source('hockey_source', 'AWARDSPLAYERS') }}
)


SELECT 
    PLAYERID,
    AWARD,
    YEAR,
    LGID,
    NOTE,
    POS
FROM raw_data
