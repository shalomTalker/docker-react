FROM node:alpine as builder
WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .
RUN npm run build

EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
