{% snapshot CDC_AWARDSPLAYERS %}

    {{
        config(
            unique_key=['PLAYERID', 'YEAR', 'AWARD'], 
            strategy='check',                         
            updated_at='YEAR',                       
            check_cols=['AWARD', 'LGID', 'NOTE', 'POS'] 
        )
    }}

    SELECT
        src.PLAYERID,                           
        src.AWARD,                               
        src.YEAR,                              
        src.LGID,                               
        src.NOTE,                                 
        src.POS,                                  
        CURRENT_TIMESTAMP AS CREATED_AT,      
        '{{ this.name }}' AS CREATED_BY,      
        CASE 
        WHEN tgt.PLAYERID IS NULL AND tgt.YEAR IS NULL AND tgt.AWARD IS NULL THEN NULL 
        ELSE CURRENT_TIMESTAMP 
    END AS VALID_TO,
    CURRENT_TIMESTAMP AS VALID_FROM
FROM 
    {{ ref('src_stg_AWARDSPLAYERS') }} AS src
LEFT JOIN 
    {{ this }} AS tgt
ON 
    src.PLAYERID = tgt.PLAYERID AND src.YEAR = tgt.YEAR AND src.AWARD = tgt.AWARD

{% endsnapshot %}
