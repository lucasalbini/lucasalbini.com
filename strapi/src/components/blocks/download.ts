export default {
  "collectionName": "components_blocks_downloads",
  "info": {
    "displayName": "Download",
    "icon": "file",
    "description": "File to download (PDF, zip, project assets...)."
  },
  "attributes": {
    "file": {
      "type": "media",
      "multiple": false,
      "required": true,
      "allowedTypes": ["files", "images", "videos", "audios"]
    },
    "label": {
      "type": "string",
      "required": true
    },
    "description": {
      "type": "text"
    }
  }
} as const;
