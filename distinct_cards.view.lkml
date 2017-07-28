view: distinct_cards {
  sql_table_name: hilary_thesis.cards_clean ;;

 dimension: primary_key{
   type: string
   sql: CONCAT(${name},${set_id},${multiverse_id_string},${color_identity}) ;;
   primary_key: yes
   hidden: yes

 }

 dimension: cmc {
    type: number
    sql: ${TABLE}.cmc ;;
  }

  dimension: color_identity {
    type: string
    sql: ${TABLE}.color_identity ;;
  }

  dimension: layout {
    type: string
    sql: ${TABLE}.layout ;;
  }

  dimension: loyalty {
    type: string
    sql: ${TABLE}.loyalty ;;
  }

  dimension: mana_cost {
    type: string
    sql: ${TABLE}.mana_cost ;;
  }

  dimension: modern_legal {
    type: string
    sql: ${TABLE}.modern_legal ;;
  }

  dimension: multiverse_id {
    type: number
    sql: ${TABLE}.multiverse_id ;;
  }

  dimension: multiverse_id_string {
    type: string
    sql: STRING(${TABLE}.multiverse_id);;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    link: {
      label: "View Card Image"
      url: "{{links.image}}"
    }
    link: {
      label: "Explore on Scryfall"
      url: "{{links.scryfall}}"
      icon_url: "https://scryfall.com/favicon.ico"
    }
    link: {
      label: "Purchase on Ebay"
      url: "{{links.ebay}}"
      icon_url: "https://ebay.com/favicon.ico"
    }
    link: {
      label: "Purchase on TCG Trader"
      url: "{{links.tcg}}"
      icon_url: "http://tcg.com/favicon.ico"
    }
  }

  dimension: oracle_text {
    type: string
    sql: ${TABLE}.oracle_text ;;
  }

  dimension: power {
    type: string
    sql: ${TABLE}.power ;;
  }

  dimension: rarity {
    type: string
    sql: ${TABLE}.rarity ;;
  }

  dimension: set_id {
    type: string
    sql: ${TABLE}.set_id ;;
  }

  dimension: set_name {
    type: string
    sql: ${TABLE}.set_name ;;
  }

  dimension: standard_legal {
    type: string
    sql: ${TABLE}.standard_legal ;;
  }

  dimension: thoughness {
    type: string
    sql: ${TABLE}.thoughness ;;
  }

  dimension: type_line {
    type: string
    sql: ${TABLE}.type_line ;;
  }

  dimension: usd_original {
    type: string
    hidden: yes
    sql: STRING(${TABLE}.usd) ;;
  }

  dimension: vintage_legal {
    type: string
    sql: ${TABLE}.vintage_legal ;;
  }

  measure: count {
    type: count
    approximate_threshold: 100000
    drill_fields: [set_name, name]
  }

  measure: average_cmc {
    type: average
    sql: ${TABLE}.cmc ;;
  }
}
