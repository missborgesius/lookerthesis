view: max_multiverse {
  derived_table: {
    sql: SELECT name, MAX(multiverse_id) as multiverse_id FROM hilary_thesis.cards_clean
    group by 1;;
}


dimension: name {
  type:  string
  sql: ${TABLE}.name ;;
  primary_key:  yes
}

dimension: multiverse_id {
  type: number
  sql: ${TABLE}.multiverse_id ;;
}

}
