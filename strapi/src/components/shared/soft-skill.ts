export default {
  "collectionName": "components_shared_soft_skills",
  "info": {
    "displayName": "Soft Skill",
    "icon": "star"
  },
  "attributes": {
    "name": {
      "type": "string",
      "required": true
    },
    "level": {
      "type": "integer",
      "min": 1,
      "max": 5
    }
  }
} as const;
