FROM node:20-alpine AS base
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm install

FROM base AS dev
COPY . .
CMD ["npm", "run", "dev"]

FROM base AS build
# NEXT_PUBLIC_* are inlined into the bundle at build time — passing them as
# runtime env in compose has no effect. Without these, sitemap.ts, robots.ts,
# feed.xml and metadataBase all fall back to http://localhost in production.
ARG NEXT_PUBLIC_SITE_URL=http://localhost
ARG NEXT_PUBLIC_API_URL=http://localhost/api
# Left empty on purpose: mediaUrl() then falls back to NEXT_PUBLIC_SITE_URL,
# which is what serves /uploads in production.
ARG NEXT_PUBLIC_STRAPI_URL=
ENV NEXT_PUBLIC_SITE_URL=$NEXT_PUBLIC_SITE_URL \
    NEXT_PUBLIC_API_URL=$NEXT_PUBLIC_API_URL \
    NEXT_PUBLIC_STRAPI_URL=$NEXT_PUBLIC_STRAPI_URL
COPY . .
RUN npm run build

FROM node:20-alpine AS production
WORKDIR /app
COPY --from=build /app/.next ./.next
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package.json ./package.json
COPY --from=build /app/public ./public
EXPOSE 3000
CMD ["npm", "run", "start"]
