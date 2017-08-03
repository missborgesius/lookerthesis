view: subtypes {
  derived_table: {
  sql: SELECT cards_clean.name as card_name,
  subtypes.name as name,
  subtypes.tribal as tribal,
  subtypes.type_dependency as type_dependency
  from hilary_thesis.cards_clean
  inner join hilary_thesis.subtypes
  on LOWER(cards_clean.type_line) LIKE CONCAT('%',' ',subtypes.name,'%')  ;;
  sql_trigger_value: 1 ;;
}

dimension: card_name {
  type:  string
  hidden: yes
  sql: ${TABLE}.card_name ;;
}

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
