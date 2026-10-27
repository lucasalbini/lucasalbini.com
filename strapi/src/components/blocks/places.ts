export default {
  "collectionName": "components_blocks_places",
  "info": {
    "displayName": "Lugares",
    "icon": "pinMap",
    "description": "Map plus list of places (restaurants, beaches, cities...)."
  },
  "attributes": {
    "title": {
      "type": "string"
    },
    "places": {
      "type": "relation",
      "relation": "oneToMany",
      "target": "api::place.place"
    }
  }
} as const;
