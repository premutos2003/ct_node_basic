FROM node:alpine

ARG port
ARG folder=./app
ARG REACT_APP_PROD_API_URL=localhost
ARG run_cmd=npm start

WORKDIR /usr/src/app

COPY ${folder} /package*.json ./

RUN npm install

COPY ./${folder} .
EXPOSE $port

CMD ${run_cmd}