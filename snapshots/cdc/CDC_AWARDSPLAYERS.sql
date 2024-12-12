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
        PLAYERID,                           
        AWARD,                               
        YEAR,                              
        LGID,                               
        NOTE,                                 
        POS,                                  
        CURRENT_TIMESTAMP AS CREATED_AT,      
        '{{ this.name }}' AS CREATED_BY,      
        NULL AS VALID_TO,                   
        CURRENT_TIMESTAMP AS VALID_FROM       
    FROM 
        {{ ref('src_stg_AWARDSPLAYERS') }}        
{% endsnapshot %}
