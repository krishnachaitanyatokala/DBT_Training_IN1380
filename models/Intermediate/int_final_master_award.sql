{{ config(materialized='table') }}

SELECT 
    a.PLAYERID AS player_id,
    a.FIRSTNAME AS first_name,
    a.LASTNAME AS last_name,
    b.YEAR AS award_year,
    b.AWARD AS award,
    b.LGID AS league_id
FROM 
    {{ ref('CDC_MASTER') }} AS a
LEFT JOIN 
    {{ ref('CDC_AWARDSPLAYERS') }} AS b 
ON 
    a.PLAYERID = b.PLAYERID