export default {
  "kind": "collectionType",
  "collectionName": "labs",
  "info": {
    "singularName": "lab",
    "pluralName": "labs",
    "displayName": "Lab",
    "description": "Low-friction notes. Deliberately not localized: each note shows up in both locales in the language it was written in, with a badge."
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
      "targetField": "title"
    },
    "date": {
      "type": "date",
      "required": true
    },
    "body": {
      "type": "blocks",
      "required": true
    },
    "external_link": {
      "type": "string"
    },
    "language": {
      "type": "enumeration",
      "enum": [
        "pt",
        "en"
      ],
      "required": true,
      "default": "pt"
    },
    "tags": {
      "type": "relation",
      "relation": "manyToMany",
      "target": "api::tag.tag",
      "inversedBy": "lab_notes"
    }
  }
} as const;
