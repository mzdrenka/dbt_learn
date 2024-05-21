{% macro learn_variables() %}

    {% set your_name_jinja = "Mateusz" %}
    {{ log("Hello " ~your_name_jinja, info=True) }}
    
    {{ log("Hello " ~var("user_name", "NO USER NAME IS SET") ~"!", info=True) }}

{% endmacro %}