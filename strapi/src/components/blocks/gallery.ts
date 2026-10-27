export default {
  "collectionName": "components_blocks_galleries",
  "info": {
    "displayName": "Galeria",
    "icon": "apps",
    "description": "Grid of photos with an optional shared caption."
  },
  "attributes": {
    "images": {
      "type": "media",
      "multiple": true,
      "required": true,
      "allowedTypes": ["images"]
    },
    "caption": {
      "type": "string"
    }
  }
} as const;
