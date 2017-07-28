view: images {
  derived_table: {
    sql: SELECT multiverse_id as multiverse_id,
      image as image_link FROM hilary_thesis.links;;
  }

  dimension: multiverse_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.multiverse_id ;;
  }

  dimension: image {
    label: "Card Image"
    sql: ${TABLE}.image_link ;;
    html: <img src="{{value}}" width="336" height="468"/>;;
  }


  }
