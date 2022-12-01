FROM node:16-alpine


# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

COPY --from=accurics/terrascan:latest /go /go

ENV PATH="/go/bin:${PATH}"

RUN apk add --no-cache g++ make py3-pip vim curl make git bash

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

ENV NODE_ENV=production

EXPOSE 8080
CMD [ "npm", "start" ]