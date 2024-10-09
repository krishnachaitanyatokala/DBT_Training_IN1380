{{ config(materialized='table')}}

SELECT * from 
{{ get_database_name() }}.HOCKEY.TEAMS
