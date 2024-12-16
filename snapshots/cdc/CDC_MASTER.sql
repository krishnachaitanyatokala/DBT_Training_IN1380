
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
    case when tgt.PLAYERID is null then null 
    when  (tgt.PLAYERID is not null  and   
    COALESCE(src.FIRSTNAME, '') != COALESCE(tgt.FIRSTNAME, '') OR
    COALESCE(src.LASTNAME, '') != COALESCE(tgt.LASTNAME, '') OR
    COALESCE(src.BIRTHYEAR, 0) != COALESCE(tgt.BIRTHYEAR, 0) OR
    COALESCE(src.BIRTHMON, 0) != COALESCE(tgt.BIRTHMON, 0) OR
    COALESCE(src.BIRTHDAY, 0) != COALESCE(tgt.BIRTHDAY, 0) OR
    COALESCE(src.DEATHYEAR, 0) != COALESCE(tgt.DEATHYEAR, 0) OR
    COALESCE(src.DEATHMON, 0) != COALESCE(tgt.DEATHMON, 0) OR
    COALESCE(src.DEATHDAY, 0) != COALESCE(tgt.DEATHDAY, 0)) then CURRENT_TIMESTAMP 
    when   src.PLAYERID is null then CURRENT_TIMESTAMP
     end as LAST_UPDATED_AT 
from {{ ref('src_stg_MASTER') }} as src
left join {{this}} as tgt
on src.PLAYERID = tgt.PLAYERID
where tgt.LAST_UPDATED_AT is null
{%endsnapshot%}