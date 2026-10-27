export default {
  "kind": "collectionType",
  "collectionName": "tags",
  "info": {
    "singularName": "tag",
    "pluralName": "tags",
    "displayName": "Tag",
    "description": "Cross-cutting taxonomy shared by posts, projects and lab notes. Portuguese only (ADR-0002)."
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
    },
    "projects": {
      "type": "relation",
      "relation": "manyToMany",
      "target": "api::project.project",
      "mappedBy": "tags"
    },
    "lab_notes": {
      "type": "relation",
      "relation": "manyToMany",
      "target": "api::lab.lab",
      "mappedBy": "tags"
    }
  }
} as const;
