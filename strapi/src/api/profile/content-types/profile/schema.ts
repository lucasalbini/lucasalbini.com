export default {
  "kind": "singleType",
  "collectionName": "profiles",
  "info": {
    "singularName": "profile",
    "pluralName": "profiles",
    "displayName": "Profile",
    "description": "Personal profile. short_bio is 2-3 lines for the hero; long_bio is used on the /about page."
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
    "role": {
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
    "short_bio": {
      "type": "text",
      "maxLength": 300,
      "pluginOptions": {
        "i18n": {
          "localized": true
        }
      }
    },
    "long_bio": {
      "type": "blocks",
      "pluginOptions": {
        "i18n": {
          "localized": true
        }
      }
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
      ],
      "pluginOptions": {
        "i18n": {
          "localized": true
        }
      }
    },
    "social_links": {
      "type": "component",
      "repeatable": true,
      "component": "shared.social-link"
    }
  }
} as const;
