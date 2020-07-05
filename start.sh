#!/bin/sh

# APP_DIRNAME is available at compose up time, not before
# so cannot move the following line to Dockerfile
APP_DIR=${NODE_SERVER_DIR}/${APP_DIRNAME}
cd ${APP_DIR}

# make npm node available in path
PATH="/usr/local/bin:${PATH}";

echo "Running npm install";

npm i;

echo "Running npm run start";

npm run start;