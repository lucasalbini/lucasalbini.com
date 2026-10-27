export default {
  "collectionName": "components_blocks_links",
  "info": {
    "displayName": "Link",
    "icon": "link",
    "description": "Highlighted external link (repo, demo, article, store...)."
  },
  "attributes": {
    "url": {
      "type": "string",
      "required": true
    },
    "title": {
      "type": "string",
      "required": true
    },
    "description": {
      "type": "text"
    }
  }
} as const;
