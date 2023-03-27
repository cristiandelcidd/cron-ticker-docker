# Development dependencies
# FROM --platform=linux/arm64 node:19.2.0-alpine3.17
FROM node:19.2.0-alpine3.17 as deps
# cd app
WORKDIR /app
COPY package.json ./
# Install dependencies
RUN npm install

# Build and tests
FROM node:19.2.0-alpine3.17 as builder
WORKDIR /app
# dest /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run test

# Production dependencies
FROM node:19.2.0-alpine3.17 as prod-deps
WORKDIR /app
# dest /app
COPY package.json ./
# Install only dependencies of production
RUN npm install --prod

# Execute the app
FROM node:19.2.0-alpine3.17 as runner
WORKDIR /app
COPY --from=prod-deps /app/node_modules ./node_modules
COPY package.json ./
COPY app.js ./
COPY tasks/ ./tasks
# RUN rm -rf tests && rm -rf node_modules
CMD [ "npm", "start" ]