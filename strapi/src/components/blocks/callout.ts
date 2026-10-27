export default {
  "collectionName": "components_blocks_callouts",
  "info": {
    "displayName": "Destaque",
    "icon": "information",
    "description": "Short highlighted note: a tip, a warning, an aside."
  },
  "attributes": {
    "body": {
      "type": "text",
      "required": true
    },
    "tone": {
      "type": "enumeration",
      "enum": ["note", "tip", "warning"],
      "default": "note",
      "required": true
    }
  }
} as const;
