export default {
  "kind": "singleType",
  "collectionName": "profiles",
  "info": {
    "singularName": "profile",
    "pluralName": "profiles",
    "displayName": "Profile"
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
    "name": {
      "type": "string",
      "required": true,
      "pluginOptions": {
        "i18n": {
          "localized": false
        }
      }
    },
    "designation": {
      "type": "string",
      "pluginOptions": {
        "i18n": {
          "localized": true
        }
      }
    },
    "company": {
      "type": "string",
      "pluginOptions": {
        "i18n": {
          "localized": false
        }
      }
    },
    "location": {
      "type": "string",
      "pluginOptions": {
        "i18n": {
          "localized": true
        }
      }
    },
    "summary": {
      "type": "richtext",
      "pluginOptions": {
        "i18n": {
          "localized": true
        }
      }
    },
    "typing_titles": {
      "type": "json",
      "pluginOptions": {
        "i18n": {
          "localized": true
        }
      }
    },
    "photo": {
      "type": "media",
      "multiple": false,
      "allowedTypes": [
        "images"
      ]
    },
    "background": {
      "type": "media",
      "multiple": false,
      "allowedTypes": [
        "images",
        "files"
      ]
    },
    "resume": {
      "type": "media",
      "multiple": false,
      "allowedTypes": [
        "files"
      ]
    },
    "social_links": {
      "type": "component",
      "repeatable": true,
      "component": "shared.social-link"
    },
    "soft_skills": {
      "type": "component",
      "repeatable": true,
      "component": "shared.soft-skill"
    }
  }
} as const;
