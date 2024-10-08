{% snapshot products_check_column_snapshot %}
    {{config(
            target_schema='DBT_KRISHNACHAITANYATOKALA',
            target_database='TRAINING',
            unique_key='product_id',
            strategy='check',
            check_cols=['product_name', 'price'] 
        )
    }}

    SELECT
        product_id,
        product_name,
        price,
        start_date,
        end_date,
        is_active
    FROM 
       TRAINING.DBT_KRISHNACHAITANYATOKALA.products

{% endsnapshot %}
