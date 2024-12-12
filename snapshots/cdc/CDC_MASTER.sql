
{% snapshot CDC_MASTER %}

    {{
        config( 
                
            unique_key='PLAYERID',                    
            strategy='check',
            check_cols=['FIRSTNAME', 'LASTNAME', 'BIRTHYEAR', 'BIRTHMON', 'BIRTHDAY', 'DEATHYEAR', 'DEATHMON', 'DEATHDAY']
        )
    }}
    select
    src.PLAYERID,
    src.FIRSTNAME,
    SRC.LASTNAME,
    SRC.BIRTHYEAR,
    SRC.BIRTHMON,
    SRC.BIRTHDAY,
    SRC.DEATHYEAR,
    SRC.DEATHMON,
    SRC.DEATHDAY,
    CURRENT_TIMESTAMP as CREATED_AT,  
    'CDC_MASTER' as CREATED_BY, 
    case when tgt.PLAYERID is null then null else 
    CURRENT_TIMESTAMP end as LAST_UPDATED_AT 
from {{ ref('src_stg_MASTER') }} as src
left join {{this}} as tgt
on src.PLAYERID = tgt.PLAYERID
{%endsnapshot%}