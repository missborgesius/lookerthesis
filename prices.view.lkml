view: prices {
  view_label: "Pricing History"
  sql_table_name: hilary_thesis.prices ;;

  dimension_group: collection {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: DATE(${TABLE}.date) ;;
  }


  dimension: multiverse_id {
    type: number
    sql: ${TABLE}.multiverse_id ;;
  }

  dimension: usd {
    type: number
    sql: ${TABLE}.usd ;;
  }

  measure: count {
    type: count
    approximate_threshold: 100000
    drill_fields: []
  }
}
