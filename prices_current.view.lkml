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
    }

   dimension_group: most_recent {
      type: time
      timeframes: [date]
      sql: ${TABLE}.a.date ;;
      label: "Date of Most Recent Pricing Data"
    }

    dimension_group: today{
      type: time
      timeframes: [date]
      sql:CURRDATE() ;;
      label: "Today's Date"
    }
    }
