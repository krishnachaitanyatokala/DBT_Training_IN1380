{{ config(materialized='ephemeral') }}

WITH hockey_stats AS (
    SELECT 
        s.playerid,
        s.year,
        t.name AS team_name,
        SUM(s.G) AS total_goals
    FROM 
        {{ source('hockey_source', 'SCORING') }} AS s 
    JOIN 
        {{ source('hockey_source', 'TEAMS') }} AS t ON s.tmid = t.tmid
    GROUP BY 
        s.playerid, s.year, t.name
)

SELECT 
    playerid,
    year,
    team_name,
    total_goals
FROM 
    hockey_stats
WHERE 
    total_goals > 0 
ORDER BY 
    total_goals DESC
