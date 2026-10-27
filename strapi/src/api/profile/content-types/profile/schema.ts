export default {
  "kind": "singleType",
  "collectionName": "profiles",
  "info": {
    "singularName": "profile",
    "pluralName": "profiles",
    "displayName": "Profile",
    "description": "Personal profile. short_bio is 2-3 lines for the hero; long_bio is used on /sobre; now is what Lucas is living right now; youtube_channel_id feeds the latest-videos section."
  },
  "options": {
    "draftAndPublish": true
  },
  "attributes": {
    "name": {
      "type": "string",
      "required": true
    },
    "role": {
      "type": "string"
    },
    "company": {
      "type": "string"
    },
    "location": {
      "type": "string"
    },
    "short_bio": {
      "type": "text",
      "maxLength": 300
    },
    "long_bio": {
      "type": "blocks"
    },
    "avatar": {
      "type": "media",
      "multiple": false,
      "allowedTypes": [
        "images"
      ]
    },
    "cv_pdf": {
      "type": "media",
      "multiple": false,
      "allowedTypes": [
        "files"
      ]
    },
    "now": {
      "type": "text",
      "maxLength": 500
    },
    "youtube_channel_id": {
      "type": "string",
      "regex": "^UC[\\w-]{22}$"
    },
    "social_links": {
      "type": "component",
      "repeatable": true,
      "component": "shared.social-link"
    }
  }
} as const;
