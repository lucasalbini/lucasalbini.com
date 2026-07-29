export default {
  "kind": "collectionType",
  "collectionName": "posts",
  "info": {
    "singularName": "post",
    "pluralName": "posts",
    "displayName": "Post",
    "description": "Editorial posts. Localized per locale (title/slug/summary/body). Cover, tags, featured are shared."
  },
  "options": {
    "draftAndPublish": true
  },
  "pluginOptions": {
    "i18n": {
      "localized": true
    }
  },
  "attributes": {
    "title": {
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
      "targetField": "title",
      "pluginOptions": {
        "i18n": {
          "localized": true
        }
      }
    },
    "summary": {
      "type": "text",
      "required": true,
      "maxLength": 200,
      "pluginOptions": {
        "i18n": {
          "localized": true
        }
      }
    },
    "body": {
      "type": "blocks",
      "required": true,
      "pluginOptions": {
        "i18n": {
          "localized": true
        }
      }
    },
    "cover": {
      "type": "media",
      "multiple": false,
      "required": true,
      "allowedTypes": [
        "images"
      ]
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
