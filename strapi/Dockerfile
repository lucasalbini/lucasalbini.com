FROM node:20-alpine AS base
RUN apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev vips-dev
WORKDIR /opt/app
COPY package.json package-lock.json* ./
RUN npm install

FROM base AS dev
COPY . .
CMD ["npm", "run", "develop"]

FROM base AS build
COPY . .
RUN npm run build

FROM node:20-alpine AS production
RUN apk add --no-cache vips-dev
WORKDIR /opt/app
COPY --from=build /opt/app ./
EXPOSE 1337
CMD ["npm", "run", "start"]
