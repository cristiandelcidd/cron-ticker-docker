# FROM --platform=linux/arm64 node:19.2.0-alpine3.17
FROM node:19.2.0-alpine3.17

# cd app
WORKDIR /app

COPY package.json ./

# Install dependencies
RUN npm install

# dest /app
COPY . .

RUN npm run test

RUN rm -rf tests && rm -rf node_modules

# Install only dependencies of production
RUN npm install --prod

CMD [ "npm", "start" ]