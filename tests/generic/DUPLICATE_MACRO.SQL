{% test DUPLICATE_MACRO(model, columns) %}
    with duplicates as (
        select
            {{ columns | join(', ') }},
            count(*) as count_of_rows
        from {{ model }}
        group by {{ columns | join(', ') }}
        having count(*) > 1
    )
    select * from duplicates
{% endtest %}
