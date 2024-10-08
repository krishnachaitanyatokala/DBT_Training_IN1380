{% snapshot products_Timestamp %}
    {{
        config(
            unique_key='product_id',
            strategy='timestamp',
            updated_at='end_date' 
        )
    }}

    SELECT
        product_id,
        product_name,
        price,
        start_date,
        end_date,
        is_active 
    FROM TRAINING.DBT_KRISHNACHAITANYATOKALA.products

{% endsnapshot %}
