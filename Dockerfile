# syntax=docker/dockerfile:1.4

FROM node:alpine AS builder

WORKDIR /app

# cache-friendly dependency install
COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build

# production stage
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
