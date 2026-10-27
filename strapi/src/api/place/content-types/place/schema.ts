export default {
  "kind": "collectionType",
  "collectionName": "places",
  "info": {
    "singularName": "place",
    "pluralName": "places",
    "displayName": "Place",
    "description": "Real-world place reused across posts (restaurant, beach, city...). Coordinates feed the maps."
  },
  "options": {
    "draftAndPublish": false
  },
  "attributes": {
    "name": {
      "type": "string",
      "required": true
    },
    "slug": {
      "type": "uid",
      "targetField": "name",
      "required": true
    },
    "kind": {
      "type": "enumeration",
      "enum": ["restaurant", "bar", "cafe", "lodging", "attraction", "nature", "city", "other"],
      "default": "other",
      "required": true
    },
    "latitude": {
      "type": "float",
      "required": true,
      "min": -90,
      "max": 90
    },
    "longitude": {
      "type": "float",
      "required": true,
      "min": -180,
      "max": 180
    },
    "address": {
      "type": "string"
    },
    "city": {
      "type": "string"
    },
    "country": {
      "type": "string"
    },
    "url": {
      "type": "string"
    },
    "note": {
      "type": "text"
    },
    "photo": {
      "type": "media",
      "multiple": false,
      "allowedTypes": ["images"]
    }
  }
} as const;
