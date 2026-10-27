export default {
  "collectionName": "components_blocks_images",
  "info": {
    "displayName": "Imagem",
    "icon": "picture",
    "description": "Single image. `wide` and `full` break out of the reading column."
  },
  "attributes": {
    "image": {
      "type": "media",
      "multiple": false,
      "required": true,
      "allowedTypes": ["images"]
    },
    "caption": {
      "type": "string"
    },
    "layout": {
      "type": "enumeration",
      "enum": ["column", "wide", "full"],
      "default": "column",
      "required": true
    }
  }
} as const;
