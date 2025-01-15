{% macro test_source_schema_changes(table_name) %}
    {% set source_name = 'hockey_source' %}
    {% set database_name = source(source_name, table_name).database %}
    {% set schema_name = source(source_name, table_name).schema %}
    
    with source_columns as (
        select 
            column_name
        from {{ database_name }}.INFORMATION_SCHEMA.COLUMNS
        where table_schema = '{{ schema_name }}'
          and table_name = upper('{{ table_name }}')
    ),
    
    expected_columns as (
        select 
            column_name
        from (
            {% for column in source(source_name, table_name)['columns'] %}
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
{% endmacro %}
