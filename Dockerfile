FROM node:22.14.0 AS base

FROM base AS dependencies

WORKDIR /usr/src/app

COPY package.json package-lock.json ./

RUN npm install

FROM base AS build

WORKDIR /usr/src/app

COPY . .
COPY --from=dependencies /usr/src/app/node_modules ./node_modules

RUN npm i tsup
RUN npm run build
RUN npm prune --prod

FROM node:22-alpine3.21 AS deploy

USER 1000

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/package.json ./package.json

EXPOSE 3333

CMD ["npm", "start"]

