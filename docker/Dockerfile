FROM node:10-alpine

RUN apk add git
RUN mkdir -p /app && \
    git clone https://github.com/rearc/quest /app
WORKDIR /app
RUN npm install
CMD [node]