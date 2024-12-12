
{{ config(
    materialized='table'
) }}

with src_data as (
    select * from {{ source('hockey_source', 'MASTER') }} 
)

select
    COALESCE(PLAYERID, '') AS PLAYERID,
    COALESCE(FIRSTNAME, '') AS FIRSTNAME,
    COALESCE(LASTNAME, '') AS LASTNAME,
    COALESCE(BIRTHYEAR, 0) AS BIRTHYEAR,  
    COALESCE(BIRTHMON, 0) AS BIRTHMON,    
    COALESCE(BIRTHDAY, 0) AS BIRTHDAY,    
    COALESCE(DEATHYEAR, 0) AS DEATHYEAR,  
    COALESCE(DEATHMON, 0) AS DEATHMON,    
    COALESCE(DEATHDAY, 0) AS DEATHDAY  
from src_data
