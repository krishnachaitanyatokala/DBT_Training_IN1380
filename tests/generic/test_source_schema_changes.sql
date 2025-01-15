with source_columns as (
    select 
        column_name
    from information_schema.columns
    where table_schema = '{{ source.schema }}'
      and table_name = '{{ source.table }}'
),

expected_columns as (
    select 
        column_name
    from (
        {% for column in source(source.database, source.table)['columns'] %}
            select '{{ column.name }}' as column_name{% if not loop.last %} union all {% endif %}
        {% endfor %}
    ) as t
),

missing_columns as (
    select 
        column_name
    from expected_columns
    where column_name not in (select column_name from source_columns)
),

extra_columns as (
    select 
        column_name
    from source_columns
    where column_name not in (select column_name from expected_columns)
)

select
    'missing' as column_status,
    column_name
from missing_columns
union all
select
    'extra' as column_status,
    column_name
from extra_columns
