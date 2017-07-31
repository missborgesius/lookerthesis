view: keywords {
  sql_table_name: hilary_thesis.keywords ;;

  dimension: keyword {
    label: "Keyword"
    type: string
    sql: ${TABLE}.string_field_0 ;;
    primary_key: yes
  }

  measure: count {
    type: count
    approximate_threshold: 100000
    drill_fields: []
  }
}
