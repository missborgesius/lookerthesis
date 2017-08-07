view: cards_gameplay {
  derived_table: {
   sql:SELECT DISTINCT name, toughness, power, loyalty, oracle_text, mana_cost, type_line, rarity, cmc, vintage_legal, standard_legal, modern_legal, set_id
        FROM hilary_thesis.cards_clean
        GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14
        ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    primary_key: yes
    link: {
      label: "Explore on Scryfall"
      url: "{{links.scryfall_uri._value}}"
      icon_url: "https://scryfall.com/favicon/ico"
    }
    link: {
      label: "Purchase on Ebay"
      url: "{{links.ebay._value}}"
      icon_url: "https://ebay.com/favicon/ico"
    }
  }

  dimension: toughness {
    type: number
    sql: CAST(${TABLE}.toughness as int64);;
  }

  dimension: power {
    type: number
    sql: CAST(${TABLE}.power as int64);;
  }

  dimension: stat_index {
    type: number
    sql: (${power}+${toughness}/2) ;;
    value_format: "0.00"
    description: "Average of Power and Toughness"
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
    description: "Stat Index over Converted Mana Cost"
    label: "Mana Index"
  }
  dimension: set_id {
    type: string
    sql: ${TABLE}.set_id ;;
    hidden: yes
  }

 dimension: subtype {
   type: string
  sql: REGEXP_EXTRACT(${type_line}, '— ([A-Za-z ,]*)') ;;
 }

  # dimension: color_identity {
  #   type: string
  #   case: {
  #     when: {
  #       sql: ${TABLE}.color_identity = "B";;
  #       label: "Black"
  #     }
  #     when: {
  #       sql: ${TABLE}.color_identity = "U";;
  #       label: "Blue"
  #     }
  #     when: {
  #       sql: ${TABLE}.color_identity = "R";;
  #       label: "Red"
  #     }
  #     when: {
  #       sql: ${TABLE}.color_identity = "G";;
  #       label: "Green"
  #     }
  #     when: {
  #       sql: ${TABLE}.color_identity = "W";;
  #       label: "White"
  #     }
  #   }
  #   label: "Color Identity"
  #   html: <a href="{{ link }}" style="color:{{value}}" target="_blank">{{ rendered_value }}</a>;;

  # }


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



  # dimension: deathtouch {
  #   view_label: "Keywords"
  #   case: {
  #     when: {
  #       sql:  REGEXP_MATCH(${oracle_text},'Deathtouch') =  true
  #             OR REGEXP_MATCH(${oracle_text},'[,] deathtouch[ \n]') = true ;;
  #       label: "has deathtouch"
  #     }
  #     # when: {
  #     #   sql: REGEXP_MATCH(${oracle_text},'(\Qhave\E|\Qgains\E|\Qhas\E|\Qgain\E|\Qand\E) deathtouch') =  true ;;
  #     #   label: "grants deathtouch"
  #     # }
  #   }
  #   drill_fields: [name]
  # }

  # measure: deathtouch_count {
  #   type: number
  #   sql: COUNT(*) WHERE ${deathtouch}="has deathtouch" ;;
  #   view_label: "Keywords"
  # }

  # dimension: defender {
  #   view_label: "Keywords"
  #   case: {
  #     when: {
  #       sql:  REGEXP_MATCH(${oracle_text},'Defender') =  true
  #         OR REGEXP_MATCH(${oracle_text},'[,] defender[ \n]') = true ;;
  #       label: "has defender"
  #     }
  #   }
  #   drill_fields: [name]
  # }

  # dimension: double_strike {
  #   view_label: "Keywords"
  #   case: {
  #     when: {
  #       sql:  REGEXP_MATCH(${oracle_text},'Double strike') =  true
  #         OR REGEXP_MATCH(${oracle_text},'[,] double strike[ \n]') = true ;;
  #       label: "has double strike"
  #     }
  #   }
  #   drill_fields: [name]
  # }

  # dimension: first_strike {
  #   view_label: "Keywords"
  #   case: {
  #     when: {
  #       sql:  REGEXP_MATCH(${oracle_text},'First strike') =  true
  #         OR REGEXP_MATCH(${oracle_text},'[,] first strike[ \n]') = true ;;
  #       label: "has first strike"
  #     }
  #   }
  #   drill_fields: [name]
  # }

  # dimension: flash {
  #   view_label: "Keywords"
  #   case: {
  #     when: {
  #       sql:  REGEXP_MATCH(${oracle_text},'Flash') =  true
  #         OR REGEXP_MATCH(${oracle_text},'[,] flash[ \n]') = true ;;
  #       label: "has flash"
  #     }
  #   }
  #   drill_fields: [name]
  # }

  # dimension: flying {
  #   view_label: "Keywords"
  #   case: {
  #     when: {
  #       sql:  REGEXP_MATCH(${oracle_text},'Flying') =  true
  #         OR REGEXP_MATCH(${oracle_text},'[,] flying[ \n]') = true ;;
  #       label: "has flying"
  #     }
  #   }
  #   drill_fields: [name]
  # }

  # dimension: haste {
  #   view_label: "Keywords"
  #   case: {
  #     when: {
  #       sql:  REGEXP_MATCH(${oracle_text},'Haste') =  true
  #         OR REGEXP_MATCH(${oracle_text},'[,] haste[ \n]') = true ;;
  #       label: "has haste"
  #     }
  #   }
  #   drill_fields: [name]
  # }

  # dimension: hexproof {
  #   view_label: "Keywords"
  #   case: {
  #     when: {
  #       sql:  REGEXP_MATCH(${oracle_text},'Hexproof') =  true
  #         OR REGEXP_MATCH(${oracle_text},'[,] hexproof[ \n]') = true ;;
  #       label: "has hexproof"
  #     }
  #   }
  #   drill_fields: [name]
  # }

  # dimension: indestructible {
  #   view_label: "Keywords"
  #   case: {
  #     when: {
  #       sql:  REGEXP_MATCH(${oracle_text},'Indestructible') =  true
  #         OR REGEXP_MATCH(${oracle_text},'[,] indestructible[ \n]') = true ;;
  #       label: "has indestructible"
  #     }
  #   }
  #   drill_fields: [name]
  # }

  # dimension: lifelink {
  #   view_label: "Keywords"
  #   case: {
  #     when: {
  #       sql:  REGEXP_MATCH(${oracle_text},'Lifelink') =  true
  #         OR REGEXP_MATCH(${oracle_text},'[,] lifelink[ \n]') = true ;;
  #       label: "has lifelink"
  #     }
  #   }
  #   drill_fields: [name]
  # }

  # dimension: menace {
  #   view_label: "Keywords"
  #   case: {
  #     when: {
  #       sql:  REGEXP_MATCH(${oracle_text},'Menace') =  true
  #         OR REGEXP_MATCH(${oracle_text},'[,] menace[ \n]') = true ;;
  #       label: "has menace"
  #     }
  #   }
  #   drill_fields: [name]
  # }

  # dimension: prowess {
  #   view_label: "Keywords"
  #   case: {
  #     when: {
  #       sql:  REGEXP_MATCH(${oracle_text},'Prowess') =  true
  #         OR REGEXP_MATCH(${oracle_text},'[,] prowess[ \n]') = true ;;
  #       label: "has prowess"
  #     }
  #   }
  #   drill_fields: [name]
  # }

  # dimension: reach {
  #   view_label: "Keywords"
  #   case: {
  #     when: {
  #       sql:  REGEXP_MATCH(${oracle_text},'Reach') =  true
  #         OR REGEXP_MATCH(${oracle_text},'[,] reach[ \n]') = true ;;
  #       label: "has reach"
  #     }
  #   }
  #   drill_fields: [name]
  # }

  # dimension: trample {
  #   view_label: "Keywords"
  #   case: {
  #     when: {
  #       sql:  REGEXP_MATCH(${oracle_text},'Trample') =  true
  #         OR REGEXP_MATCH(${oracle_text},'[,] trample[ \n]') = true ;;
  #       label: "has trample"
  #     }
  #   }
  #   drill_fields: [name]
  # }

  # dimension: vigilance {
  #   view_label: "Keywords"
  #   case: {
  #     when: {
  #       sql:  REGEXP_MATCH(${oracle_text},'Vigilance') =  true
  #         OR REGEXP_MATCH(${oracle_text},'[,] vigilance[ \n]') = true ;;
  #       label: "has vigilance"
  #     }
  #   }
  #   drill_fields: [name]
  # }
