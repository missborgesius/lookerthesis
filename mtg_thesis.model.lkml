connection: "bq_mtg"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

explore: cards_gameplay {
  join: max_multiverse {
    sql_on: ${cards_gameplay.name}=${max_multiverse.name} ;;
    relationship: many_to_one
  }

  join: images {
    sql_on: ${max_multiverse.multiverse_id}=${images.multiverse_id} ;;
    relationship: one_to_one
    type: inner
  }

  join: links {
    sql_on: ${max_multiverse.name}=${links.name} ;;
    relationship: one_to_one
  }
}
