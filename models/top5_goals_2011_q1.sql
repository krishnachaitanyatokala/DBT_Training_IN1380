{{ config(materialized='table') }}

SELECT t.name as Team_Name, s.year, COUNT(s.G) AS no_of_goals
FROM HOCKEYDB.HOCKEY.SCORING s
JOIN HOCKEYDB.HOCKEY.TEAMS t ON s.tmid = t.tmid
WHERE s.year = 2011
GROUP BY t.name, s.year
ORDER BY no_of_goals DESC
LIMIT 5;
