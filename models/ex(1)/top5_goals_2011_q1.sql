{{ config(materialized='table') }}

WITH a AS (
    SELECT 
        t.name AS Team_Name, 
        s.year, 
        SUM(s.G) AS no_of_goals, 
        ROW_NUMBER() OVER (PARTITION BY s.year ORDER BY SUM(s.G) DESC) AS rank_1
    FROM 
        HOCKEYDB.HOCKEY.SCORING s
    JOIN 
        HOCKEYDB.HOCKEY.TEAMS t ON s.tmid = t.tmid
    WHERE 
        s.year = 2011
    GROUP BY 
        t.name, s.year
)
SELECT 
    Team_Name, 
    year, 
    no_of_goals 
FROM 
    a 
WHERE 
    rank_1 <= 5
