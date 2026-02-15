import type { Schema, Struct } from '@strapi/strapi';

export interface SharedPosition extends Struct.ComponentSchema {
  collectionName: 'components_shared_positions';
  info: {
    displayName: 'Position';
    icon: 'briefcase';
  };
  attributes: {
    designation: Schema.Attribute.String & Schema.Attribute.Required;
    end_date: Schema.Attribute.Date;
    is_current: Schema.Attribute.Boolean & Schema.Attribute.DefaultTo<false>;
    responsibilities: Schema.Attribute.Component<'shared.responsibility', true>;
    start_date: Schema.Attribute.Date & Schema.Attribute.Required;
  };
}

export interface SharedResponsibility extends Struct.ComponentSchema {
  collectionName: 'components_shared_responsibilities';
  info: {
    displayName: 'Responsibility';
    icon: 'bulletList';
  };
  attributes: {
    description: Schema.Attribute.Text & Schema.Attribute.Required;
  };
}

export interface SharedSocialLink extends Struct.ComponentSchema {
  collectionName: 'components_shared_social_links';
  info: {
    displayName: 'Social Link';
    icon: 'link';
  };
  attributes: {
    icon_name: Schema.Attribute.String;
    platform: Schema.Attribute.String & Schema.Attribute.Required;
    url: Schema.Attribute.String & Schema.Attribute.Required;
  };
}

export interface SharedSoftSkill extends Struct.ComponentSchema {
  collectionName: 'components_shared_soft_skills';
  info: {
    displayName: 'Soft Skill';
    icon: 'star';
  };
  attributes: {
    level: Schema.Attribute.Integer &
      Schema.Attribute.SetMinMax<
        {
          max: 5;
          min: 1;
        },
        number
      >;
    name: Schema.Attribute.String & Schema.Attribute.Required;
  };
}

declare module '@strapi/strapi' {
  export module Public {
    export interface ComponentSchemas {
      'shared.position': SharedPosition;
      'shared.responsibility': SharedResponsibility;
      'shared.social-link': SharedSocialLink;
      'shared.soft-skill': SharedSoftSkill;
    }
  }
}
