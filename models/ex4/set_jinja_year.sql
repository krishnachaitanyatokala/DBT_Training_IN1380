{{ config(materialized='table') }}

{% set target_year_query %}
    SELECT MAX(YEAR) AS max_year 
    FROM HOCKEYDB.HOCKEY.SCORINGSHOOTOUT
{% endset %}

{% set target_year_result = run_query(target_year_query) %}

{% if target_year_result is not none %}
    {% set target_year = target_year_result.columns[0][0] %}
{% else %}
    {% set target_year = 'NA' %} 
{% endif %}

SELECT 
    COALESCE(playerid, 'NA') AS playerid,
    COALESCE(year, 'NA') AS year,
    COALESCE(POS, 'NA') AS POS,  
    COALESCE(GP, 0) AS GP,
    CASE 
        WHEN year = {{ target_year }} THEN 'Current Year Player'
        ELSE 'Previous Year Player'
    END AS player_category
FROM 
    HOCKEYDB.HOCKEY.SCORING
WHERE 
    year = {{ target_year }};