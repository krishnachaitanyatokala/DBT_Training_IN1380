{% snapshot CDC_AWARDSPLAYERS %}

    {{
        config(
            unique_key=['PLAYERID', 'YEAR', 'AWARD'], 
            strategy='check',                                                
            check_cols=[ 'LGID', 'NOTE', 'POS'],
            invalidate_hard_delete='true',
post_hook=["
            UPDATE {{ this }}
            SET 
                change_type_flag = 'D',
                VALID_TO = CURRENT_TIMESTAMP
            WHERE PLAYERID||YEAR||AWARD NOT IN (
                SELECT PLAYERID||YEAR||AWARD  FROM {{ ref('src_stg_AWARDSPLAYERS')}}

            );" ,

            "UPDATE {{ this }}
            SET 
                change_type_flag = 'U',
                VALID_TO = CURRENT_TIMESTAMP
            WHERE change_type_flag = 'I'
                AND DBT_VALID_TO IS NOT NULL
        "]
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
    CURRENT_TIMESTAMP AS VALID_FROM,
    'I' as change_type_flag 
FROM 
    {{ ref('src_stg_AWARDSPLAYERS') }} AS src
LEFT JOIN 
    {{ this }} AS tgt
ON 
    src.PLAYERID = tgt.PLAYERID AND src.YEAR = tgt.YEAR AND src.AWARD = tgt.AWARD

{% endsnapshot %}
