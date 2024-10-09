  version: 2

models:
  - name: incremental_coaches_q3
    tests:
      - dbt_utils.no_duplicate_rows:
          column_names: ['*']
