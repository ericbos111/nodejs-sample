# Install the app dependencies in a full Node docker image
FROM registry.access.redhat.com/ubi8/nodejs-14:latest

WORKDIR "/app"

# Copy package.json and package-lock.json
COPY package*.json ./

# Install app dependencies
RUN npm install --production

# Copy the dependencies into a Slim Node docker image
FROM registry.access.redhat.com/ubi8/nodejs-14-minimal:latest

WORKDIR "/app"

# Install app dependencies
COPY --from=0 /app/node_modules /app/node_modules
COPY . /app

ENV NODE_ENV production
ENV PORT 3000

EXPOSE 3000
CMD ["npm", "start"]
