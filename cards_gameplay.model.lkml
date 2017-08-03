connection: "bq_mtg"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

explore: cards_gameplay {
  sql_always_where: ${sets.set_type} = "expansion" OR ${sets.set_type} = "core" ;;
  join: sets {
    sql_on: ${sets.code}=${cards_gameplay.set_id} ;;
    relationship: one_to_many
  }
  join: links {
    sql_on: ${cards_gameplay.name}=${links.name} ;;
    relationship: one_to_many
  }
  join: subtypes {
    sql_on: ${cards_gameplay.name}=${subtypes.card_name};;
    relationship: many_to_many
    type: inner
  }
}
