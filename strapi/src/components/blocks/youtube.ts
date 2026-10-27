export default {
  "collectionName": "components_blocks_youtubes",
  "info": {
    "displayName": "YouTube",
    "icon": "play",
    "description": "YouTube video. Paste any watch, youtu.be or shorts URL."
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
