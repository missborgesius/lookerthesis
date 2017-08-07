view: types {
  sql_table_name: hilary_thesis.types ;;

  dimension: type {
    type: string
    sql: ${TABLE}.string_field_0 ;;
    primary_key: yes
  }

  dimension: permanance {
    type: string
    sql: ${TABLE}.string_field_1 ;;
  }

  dimension: speed {
    type: string
    sql: ${TABLE}.string_field_2 ;;
  }

  measure: count {
    type: count
    approximate_threshold: 100000
    drill_fields: []
  }
}
