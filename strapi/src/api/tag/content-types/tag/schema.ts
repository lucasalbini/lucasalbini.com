export default {
  "kind": "collectionType",
  "collectionName": "tags",
  "info": {
    "singularName": "tag",
    "pluralName": "tags",
    "displayName": "Tag",
    "description": "Cross-cutting taxonomy for posts. Portuguese only (ADR-0002)."
  },
  "options": {
    "draftAndPublish": false
  },
  "attributes": {
    "label": {
      "type": "string",
      "required": true
    },
    "slug": {
      "type": "uid",
      "targetField": "label"
    },
    "posts": {
      "type": "relation",
      "relation": "manyToMany",
      "target": "api::post.post",
      "mappedBy": "tags"
    }
  }
} as const;
