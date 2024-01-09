FROM node:12.13.0-alpine as n8n-build

N8N_VERSION

RUN if [ -z "$N8N_VERSION" ] ; then echo "The N8N_VERSION argument is missing!" ; exit 1; fi

# Update everything and install needed dependencies
RUN apk add --update graphicsmagick tzdata git

# # Set a custom user to not have n8n run as root
USER root

# Install n8n and the also temporary all the packages
# it needs to build it correctly.
RUN apk --update add --virtual build-dependencies python build-base ca-certificates

RUN npm i lerna -g --loglevel notice

WORKDIR /data

COPY package.json .
RUN npm install --loglevel notice

COPY packages/cli/ ./packages/cli/
COPY packages/core/ ./packages/core/
COPY packages/editor-ui/ ./packages/editor-ui/
COPY packages/nodes-base/ ./packages/nodes-base/
COPY packages/workflow/ ./packages/workflow/



COPY lerna.json .
RUN lerna bootstrap --hoist

RUN npm run build
