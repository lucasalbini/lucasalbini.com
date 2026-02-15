export default {
  "collectionName": "components_shared_social_links",
  "info": {
    "displayName": "Social Link",
    "icon": "link"
  },
  "attributes": {
    "platform": {
      "type": "string",
      "required": true
    },
    "url": {
      "type": "string",
      "required": true
    },
    "icon_name": {
      "type": "string"
    }
  }
} as const;
