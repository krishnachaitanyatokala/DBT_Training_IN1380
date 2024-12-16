{% snapshot CDC_MASTER %}
{{
    config(
        unique_key='PLAYERID',
        strategy='check',
        invalidate_hard_delete='true',
        check_cols=['FIRSTNAME', 'LASTNAME', 'BIRTHYEAR', 'BIRTHMON', 'BIRTHDAY', 'DEATHYEAR', 'DEATHMON', 'DEATHDAY'],
        post_hook=["
            UPDATE {{ this }}
            SET 
                change_type_flag = 'D',
                LAST_UPDATED_AT = CURRENT_TIMESTAMP
            WHERE PLAYERID NOT IN (
                SELECT PLAYERID FROM {{ ref('src_stg_MASTER') }}
            );" ,

            "UPDATE {{ this }}
            SET 
                change_type_flag = 'U',
                LAST_UPDATED_AT = CURRENT_TIMESTAMP
            WHERE change_type_flag = 'I'
                AND DBT_VALID_TO IS NOT NULL
        "]
    )
}}

    SELECT
        src.PLAYERID,
        src.FIRSTNAME,
        src.LASTNAME,
        src.BIRTHYEAR,
        src.BIRTHMON,
        src.BIRTHDAY,
        src.DEATHYEAR,
        src.DEATHMON,
        src.DEATHDAY,
        CURRENT_TIMESTAMP AS CREATED_AT,  
        'CDC_MASTER' AS CREATED_BY, 
        NULL AS LAST_UPDATED_AT,
        'I' AS change_type_flag
    FROM {{ ref('src_stg_MASTER') }} AS src
    LEFT JOIN {{ this }} AS tgt
        ON src.PLAYERID = tgt.PLAYERID
    WHERE tgt.DBT_VALID_TO IS NULL
{% endsnapshot %}