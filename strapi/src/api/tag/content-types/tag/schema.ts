export default {
  "kind": "collectionType",
  "collectionName": "tags",
  "info": {
    "singularName": "tag",
    "pluralName": "tags",
    "displayName": "Tag",
    "description": "Cross-cutting taxonomy shared by posts, projects and lab notes. Label is localized so the slug renders per locale."
  },
  "options": {
    "draftAndPublish": false
  },
  "pluginOptions": {
    "i18n": {
      "localized": true
    }
  },
  "attributes": {
    "label": {
      "type": "string",
      "required": true,
      "pluginOptions": {
        "i18n": {
          "localized": true
        }
      }
    },
    "slug": {
      "type": "uid",
      "targetField": "label",
      "pluginOptions": {
        "i18n": {
          "localized": true
        }
      }
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
