export default {
  "kind": "collectionType",
  "collectionName": "posts",
  "info": {
    "singularName": "post",
    "pluralName": "posts",
    "displayName": "Post",
    "description": "The full version of anything Lucas lived or made: travel, project, idea, life, work. Body is a list of blocks."
  },
  "options": {
    "draftAndPublish": true
  },
  "attributes": {
    "title": {
      "type": "string",
      "required": true
    },
    "slug": {
      "type": "uid",
      "targetField": "title",
      "required": true
    },
    "summary": {
      "type": "text",
      "required": true,
      "maxLength": 300
    },
    "cover": {
      "type": "media",
      "multiple": false,
      "allowedTypes": ["images"]
    },
    "category": {
      "type": "enumeration",
      "enum": ["travel", "project", "idea", "life", "work"],
      "required": true
    },
    "visibility": {
      "type": "enumeration",
      "enum": ["public", "unlisted", "private"],
      "default": "public",
      "required": true
    },
    "date": {
      "type": "date",
      "required": true
    },
    "instagram_url": {
      "type": "string"
    },
    "youtube_url": {
      "type": "string"
    },
    "body": {
      "type": "dynamiczone",
      "components": [
        "blocks.text",
        "blocks.image",
        "blocks.gallery",
        "blocks.youtube",
        "blocks.instagram",
        "blocks.places",
        "blocks.download",
        "blocks.link",
        "blocks.callout"
      ]
    },
    "collection": {
      "type": "relation",
      "relation": "manyToOne",
      "target": "api::collection.collection",
      "inversedBy": "posts"
    },
    "tags": {
      "type": "relation",
      "relation": "manyToMany",
      "target": "api::tag.tag",
      "inversedBy": "posts"
    },
    "featured": {
      "type": "boolean",
      "default": false
    },
    "featured_order": {
      "type": "integer",
      "default": 0
    }
  }
} as const;
