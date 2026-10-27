export default {
  "kind": "collectionType",
  "collectionName": "projects",
  "info": {
    "singularName": "project",
    "pluralName": "projects",
    "displayName": "Project",
    "description": "Portfolio projects: games, AI, tools, tutorials. Text is localized; kind/status/stack/urls/year are shared."
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
    "status": {
      "type": "enumeration",
      "enum": [
        "active",
        "paused",
        "archived",
        "experiment"
      ],
      "default": "active",
      "required": true
    },
    "kind": {
      "type": "enumeration",
      "enum": [
        "game",
        "ai",
        "tool",
        "tutorial"
      ],
      "required": true
    },
    "stack": {
      "type": "relation",
      "relation": "manyToMany",
      "target": "api::skill.skill"
    },
    "tags": {
      "type": "relation",
      "relation": "manyToMany",
      "target": "api::tag.tag",
      "inversedBy": "projects"
    },
    "repo_url": {
      "type": "string"
    },
    "demo_url": {
      "type": "string"
    },
    "itch_embed_url": {
      "type": "string"
    },
    "year": {
      "type": "integer"
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
