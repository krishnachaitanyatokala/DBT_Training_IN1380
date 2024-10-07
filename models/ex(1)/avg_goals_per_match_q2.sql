{{ config(materialized='table') }}

SELECT t.name, 
       AVG(s.G) AS avg_goals_per_match
FROM HOCKEYDB.HOCKEY.SCORING s
JOIN HOCKEYDB.HOCKEY.TEAMS t ON s.tmid = t.tmid
GROUP BY t.name;