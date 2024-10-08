WITH player_stats AS (
    SELECT *
    FROM {{ ref('ephemeral_hockey_model') }}
)

SELECT 
    playerid,
    year,
    team_name,
    total_goals
FROM 
    player_stats
WHERE 
    total_goals >= 10