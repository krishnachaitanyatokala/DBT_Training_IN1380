{% macro generate_model_yaml(model_name) %}

    {% set relation = ref(model_name) %}
   {% set database_name = relation.database %}
    {% set table_name = relation.identifier %}
    {% set columns_query %}
        SELECT column_name
        FROM {{ database_name }}.INFORMATION_SCHEMA.COLUMNS
        WHERE table_name = upper('{{ table_name }}')
    {% endset %}

    {% set results = run_query(columns_query) %}
    
    {% if execute %}
        {% set columns = results.columns[0].values() %}
    {% else %}
        {% set columns = [] %}
    {% endif %}

    {{ log("Generating YAML for model: " ~ model_name, info=True) }}

    version: 2
    models:
      - name: {{ model_name }}
        description: "Describe the purpose of this model"
        columns:
        {% for column in columns %}
          - name: {{ column }}
            description: "Describe this column"
        {% endfor %}

{% endmacro %}
