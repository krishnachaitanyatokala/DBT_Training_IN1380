{{ config(
    materialized='table'
) }}

with src_data as (
    select * from {{ source('hockey_source', 'MASTER') }}
)

select
    COALESCE(playerid, '') as playerid,
    COALESCE(firstname, '') as firstname,
    COALESCE(lastname, '') as lastname,
    COALESCE(birthyear, 0) as birthyear,
    COALESCE(birthmon, 0) as birthmon,
    COALESCE(birthday, 0) as birthday,
    COALESCE(deathyear, 0) as deathyear,
    COALESCE(deathmon, 0) as deathmon,
    COALESCE(deathday, 0) as deathday
from src_data
