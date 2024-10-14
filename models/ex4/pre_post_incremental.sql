{{ config(
    materialized = 'incremental', 
    unique_key = ['COACHID', 'YEAR', 'STINT'],
    pre_hook=[
        "{% if is_incremental() %} TRUNCATE TABLE {{ this }}; {% endif %}"
    ],
    post_hook=[
        "INSERT INTO audit_log (model_name, run_time, record_count) VALUES ('{{ this }}', current_timestamp, (SELECT COUNT(*) FROM {{ this }}));"
    ]
) }}

WITH new_data AS (
    SELECT *
    FROM {{ source('hockey_source', 'COACHES') }}
    {% if is_incremental() %}
        WHERE (COACHID, YEAR, STINT) NOT IN (SELECT COACHID, YEAR, STINT FROM {{ this }})
    {% endif %}
)

SELECT * FROM new_data
