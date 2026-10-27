export default {
  "collectionName": "components_blocks_instagrams",
  "info": {
    "displayName": "Instagram",
    "icon": "picture",
    "description": "Instagram post or reel, rendered with the official embed."
  },
  "attributes": {
    "url": {
      "type": "string",
      "required": true
    },
    "caption": {
      "type": "string"
    }
  }
} as const;
