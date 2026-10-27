export default {
  "kind": "collectionType",
  "collectionName": "collections",
  "info": {
    "singularName": "collection",
    "pluralName": "collections",
    "displayName": "Collection",
    "description": "Optional ordered group of posts (e.g. Viagens). Posts are ordered by date ascending, like chapters."
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
    "description": {
      "type": "text"
    },
    "cover": {
      "type": "media",
      "multiple": false,
      "allowedTypes": ["images"]
    },
    "posts": {
      "type": "relation",
      "relation": "oneToMany",
      "target": "api::post.post",
      "mappedBy": "collection"
    }
  }
} as const;
