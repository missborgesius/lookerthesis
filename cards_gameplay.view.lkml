view: cards_gameplay {
  derived_table: {
   sql:SELECT name, toughness, power, loyalty, oracle_text, mana_cost, type_line, rarity, cmc, vintage_legal, standard_legal, modern_legal, color_identity, set_id, layout
        FROM hilary_thesis.cards_clean
        GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
        ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    primary_key: yes
    link: {
      label: "Explore on Scryfall"
      url: "{{links.scryfall.value}}"
      icon_url: "https://scryfall.com/favicon/ico"
    }
  }

  dimension: toughness {
    type: number
    sql: INTEGER(${TABLE}.toughness) ;;
  }

  dimension: power {
    type: number
    sql: INTEGER(${TABLE}.power) ;;
  }

  dimension: stat_index {
    type: number
    sql: (${power}+${toughness}/2) ;;
    value_format: "0.00"
  }

  dimension: loyalty {
    type:  number
    sql: ${TABLE}.loyalty ;;
  }

  dimension: oracle_text {
    type: string
    sql: ${TABLE}.oracle_text ;;
  }

  dimension: mana_cost {
    type: string
    sql: ${TABLE}.mana_cost ;;
  }

  dimension: type_line {
    type: string
    sql: ${TABLE}.type_line ;;
  }

  dimension: type {
    case: {
      when: {
        sql: ${type_line} LIKE '%Artifact Creature%' ;;
        label: "Artifact Creature"
      }
      when: {
        sql: ${type_line} LIKE '%Enchantment Creature%' ;;
        label: "Enchantment Creature"
      }
      when: {
        sql: ${type_line} LIKE '%Creature%' ;;
        label: "Creature"
      }
      when: {
        sql: ${type_line} LIKE '%Artifact%' ;;
        label: "Artifact"
      }
      when: {
        sql: ${type_line} LIKE '%Land%'
            AND ${name}!="Mountain"
            AND ${name}!="Swamp"
            AND ${name}!="Forest"
            AND ${name}!="Mountain"
            AND ${name}!="Plains";;
        label: "Non-Basic Land"
      }
      when: {
        sql:
            ${name}="Mountain"
            OR ${name}="Swamp"
            OR ${name}="Forest"
            OR ${name}="Mountain"
            OR ${name}="Plains";;
        label: "Basic Land"
      }
      when: {
        sql: ${type_line} LIKE '%Sorcery%' ;;
        label: "Sorcery"
      }
      when: {
        sql: ${type_line} LIKE '%Instant%' ;;
        label: "Instant"
      }
      when: {
        sql: ${type_line} LIKE '%Enchantment%' ;;
        label: "Enchantment"
      }
      when: {
        sql: ${type_line} LIKE '%Planeswalker%' ;;
        label: "Planeswalker"
      }
    }
  }
  dimension: permanent {
    type: yesno
    sql: ${type} != "Instant"
    OR ${type} != "Sorcery";;
  }
  dimension: rarity {
    type: string
    sql: ${TABLE}.rarity ;;
  }
  dimension: cmc {
    label: "Converted Mana Cost"
    type: number
    sql: ${TABLE}.cmc ;;
  }
  dimension: mana_index {
    type: number
    sql: ${stat_index}/${cmc} ;;
    value_format: "0.00"
  }
  dimension: set_id {
    type: string
    sql: ${TABLE}.set_id ;;
  }

  measure: count {
    type: count
  }

  measure: average_stats_index{
    type: average
    sql: ${stat_index} ;;
    value_format: "0.00"
  }

  measure: average_mana_index {
    type: average
    sql: ${mana_index} ;;
    value_format: "0.00"
  }
}
