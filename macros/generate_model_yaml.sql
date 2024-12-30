{% macro generate_model_yaml(model_name) %}

    {# Set the reference to the model #}
    {% set relation = ref(model_name) %}
    
    {# Query to get the column names from the model's table #}
    {% set columns_query %}
        SELECT column_name
        FROM TRAINING.INFORMATION_SCHEMA.COLUMNS
    WHERE table_name = upper('{{ relation }}')
    {% endset %}
    
    {# Execute the query to get column names #}
    {% set results = run_query(columns_query) %}
    
    {# Initialize the list of columns if executing, otherwise leave empty #}
    {% if execute %}
        {% set columns = results.columns[0].values() %}
    {% else %}
        {% set columns = [] %}
    {% endif %}

    {# Start constructing the YAML content #}
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
