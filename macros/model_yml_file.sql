{% macro generate_custom_yaml(model_name) %}
    {% set yaml_content = generate_model_yaml(model_name=model_name) %}
    {{ log(yaml_content, info=True) }}
{% endmacro %}
