view: links {
  derived_table: {
  sql: select * from hilary_thesis.links;;
  }

  dimension: multiverse_id_string {
    type: string
    hidden: yes
    sql: STRING(${TABLE}.multiverse_id) ;;
  }

  dimension: primary_key {
    type: string
    hidden: yes
    sql: CONCAT(${TABLE}.multiverse_id,${TABLE}.name,${TABLE}.scryfall) ;;
    primary_key: yes
  }

  dimension: multiverse_id {
    type: number
    sql: ${TABLE}.multiverse_id ;;
    hidden: yes
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    hidden: yes
  }

  dimension: scryfall_uri {
    type: string
    sql: ${TABLE}.scryfall_uri ;;
    link: {
      label: "View on Scryfall"
      url: "{{value}}"
      icon_url: "https://scryfall.com/favicon.ico"

    }
    hidden: yes
  }

  dimension: scryfall_set {
    label: "set link"
    type: string
    sql: ${TABLE}.scryfall_set ;;
    link: {
      label: "View Set"
      url: "{{value}}"
      icon_url: "https://scryfall.com/favicon.ico"
    }
    hidden: yes
  }

  dimension: ebay {
    type: string
    sql: ${TABLE}.ebay ;;
    link: {
      label: "Purchase on Ebay"
      url: "{{value}}"
      icon_url: "https://www.ebay.com/favicon.ico"
    }
    hidden: yes
  }

  dimension: tcgplayer {
    type: string
    sql: ${TABLE}.tcgplayer ;;
    link: {
      label: "Purchase on TCG Player"
      url: "{{value}}"
      icon_url: "http://www.tcgplayer.com/favicon.ico"
    }
    hidden: yes
  }

  dimension: image {
    type: string
    sql: ${TABLE}.image ;;
    link: {
      label: "View Card"
      url: "{{value}}"
    }
    hidden: yes
  }

}
