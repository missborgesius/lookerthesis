view: subtypes {
  sql_table_name: hilary_thesis.subtypes ;;

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: tribal {
    type: yesno
    sql: ${TABLE}.tribal ;;
  }

  dimension: type_dependency {
    type: string
    sql: ${TABLE}.type_dependency ;;
  }

  measure: count {
    type: count
    approximate_threshold: 100000
    drill_fields: [name]
  }
}
