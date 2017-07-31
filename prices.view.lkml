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

  dimension: date_string {
    hidden: yes
    sql: STRING(${TABLE}.date) ;;
  }
  dimension: multiverse_string {
    hidden: yes
    sql: STRING(${TABLE}.multiverse_id) ;;
  }
  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${multiverse_string},${date_string}) ;;
  }

  dimension: multiverse_id {
    type: number
    sql: ${TABLE}.multiverse_id ;;
  }

  dimension: usd {
    type: number
    sql: ${TABLE}.usd ;;
    value_format_name: usd
  }

  measure: count {
    type: count
    approximate_threshold: 100000
    drill_fields: []
  }

  measure: average_price {
    type: average
    sql: ${TABLE}.usd ;;
    drill_fields: [collection_date,multiverse_id]
    value_format_name: usd
  }

  measure: max_price {
    type:  max
    sql: ${TABLE}.usd ;;
    drill_fields: [collection_date,multiverse_id]
    value_format_name: usd
  }

  measure: min_price {
    type: min
    sql: ${TABLE}.usd ;;
    drill_fields: [collection_date,multiverse_id]
    value_format_name: usd
  }


}
