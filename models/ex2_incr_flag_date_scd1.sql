{{ config(
    materialized = 'incremental', 
    unique_key = 'PRODUCT_ID'  
) }}

WITH source_data AS (
    SELECT 
        *
    FROM 
        TRAINING.DBT_KRISHNACHAITANYATOKALA.products_check_column_snapshot
    WHERE 
        IS_ACTIVE = 'TRUE' 
        OR (CURRENT_DATE() - END_DATE <= 7)  
),

existing_records AS (
    SELECT 
        *
    FROM 
        {{ this }}  
)


SELECT 
    src.*
FROM 
    source_data src
LEFT JOIN 
    existing_records ex 
ON 
    src.PRODUCT_ID = ex.PRODUCT_ID  

{% if is_incremental() %}
WHERE 
    ex.your_unique_key_column IS NULL  
    OR src.current_flag = 'Y'  
{% endif %}