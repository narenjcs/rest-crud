FROM node:current-alpine3.14 as node

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

RUN cd dist && ls

# Stage 2
FROM nginx:1.13.12-alpine

COPY --from=node /usr/src/app/dist/angular.realworld.io /usr/share/nginx/html

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
