{%- set yaml_metadata -%}
source_model: 'stg_customers'
derived_columns:
  CUSTOMER_KEY: 'customer_id'
hashed_columns:
  CUSTOMER_PK: 'customer_id'
  CUSTOMER_HASHDIFF:
    is_hashdiff: true
    columns:
      - 'customer_id'
      - 'first_name'
      - 'last_name'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}
{% set source_model = metadata_dict['source_model'] %}
{% set derived_columns = metadata_dict['derived_columns'] %}
{% set hashed_columns = metadata_dict['hashed_columns'] %}

WITH staging AS (
{{ dbtvault.stage(include_source_columns=true,
                  source_model=source_model,
                  derived_columns=derived_columns,
                  hashed_columns=hashed_columns,
                  ranked_columns=none) }}
)
SELECT *
FROM staging