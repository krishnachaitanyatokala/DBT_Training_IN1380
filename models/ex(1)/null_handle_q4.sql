 {{ config(materialized='table') }}
 
 SELECT 
    COALESCE(playerid,'NA') AS playerid,
    COALESCE(year,'NA') AS year ,
    COALESCE(POS, 'NA') AS POS,  
    COALESCE(GP, 0) AS GP          
FROM 
    HOCKEYDB.HOCKEY.SCORING;
