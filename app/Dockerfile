FROM node:lts-hydrogen as builder

COPY . /app
WORKDIR /app/spoved-app
RUN npm install
RUN npm run build
RUN rm -rf node_modules

FROM nginx:stable-bullseye as production
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/build .
EXPOSE 80
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]