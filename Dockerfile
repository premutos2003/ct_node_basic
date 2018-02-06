FROM node:carbon

ARG port

WORKDIR /usr/src/app
COPY /app/package*.json ./
RUN npm install
COPY ./app .
EXPOSE $port
CMD [ "npm", "start" ]