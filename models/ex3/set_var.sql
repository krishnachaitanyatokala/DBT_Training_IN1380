

WITH filtered_teams AS (
    SELECT
        team_name,
        year,
        no_of_goals
    FROM {{ ref('top5_goals_2011_q1') }}
    WHERE team_name = '{{ var("team_filter", "All Teams") }}'
)
SELECT * FROM filtered_teams