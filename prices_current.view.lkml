view: prices_current {
  view_label: "Current Pricing"
  derived_table: {
  sql: SELECT a.multiverse_id, a.usd, a.date FROM
hilary_thesis.prices a
INNER JOIN (
  SELECT multiverse_id, MAX(date) as max_date FROM hilary_thesis.prices
  GROUP BY multiverse_id) b
  ON a.multiverse_id=b.multiverse_id AND a.date=b.max_date ;;
    }

    dimension: multiverse_id {
      type: number
      sql: ${TABLE}.a.multiverse_id ;;
      primary_key: yes
    }

    dimension: current_price {
      type: number
      sql: ${TABLE}.a.usd ;;
      value_format_name: usd
    }

   dimension_group: most_recent {
      type: time
      timeframes: [date]
      sql: ${TABLE}.a.date ;;
      label: "Date of Most Recent Pricing Data"
    }
   measure: avg_current_price {
     type: average
    sql: ${current_price} ;;
    value_format_name: usd
   }

  measure: max_current_price {
    type: max
    sql: ${current_price} ;;
    value_format_name: usd

  }

  measure: min_current_price {
    type: min
    sql: ${current_price} ;;
    value_format_name: usd
  }

  measure: total_price {
    type: sum
    sql: ${current_price} ;;
    value_format_name: usd

  }


    }
