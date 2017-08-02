view: subtypes {
  sql_table_name: hilary_thesis.subtypes ;;

  dimension: name {
    primary_key: yes
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

    drill_fields: [name]
  }
}
