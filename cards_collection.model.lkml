connection: "bq_mtg"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

explore: distinct_cards {
  sql_always_where: ${sets.set_type} = "expansion" OR ${sets.set_type} = "core" ;;
  join: sets {
    sql_on: ${distinct_cards.set_id}=${sets.code} ;;
    relationship: many_to_one
  }
  join: prices {
    sql_on: ${distinct_cards.multiverse_id}=${prices.multiverse_id} ;;
    relationship: many_to_many
  }
  join: links {
    sql_on: ${distinct_cards.multiverse_id}=${links.multiverse_id} ;;
    relationship: many_to_many
  }
  join: images {
    sql_on: ${distinct_cards.multiverse_id}=${images.multiverse_id} ;;
    relationship: many_to_one
  }
}

explore: prices_current {
  label: "Current Pricing Data"
  sql_always_where: ${prices_current.current_price} is not null;;
  join: distinct_cards {
    sql_on: ${prices_current.multiverse_id}=${distinct_cards.multiverse_id} ;;
    relationship: one_to_many
    type: inner
  }
  join: links {
    sql_on: ${prices_current.multiverse_id}=${links.multiverse_id} ;;
    relationship: one_to_many
  }
  join: images {
    sql_on: ${prices_current.multiverse_id}=${images.multiverse_id} ;;
    relationship: one_to_one
  }
}
