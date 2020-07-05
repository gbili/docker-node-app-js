FROM node:erbium-alpine3.12

ARG APP_PORT=3100
ARG APP_DIRNAME=appname
# take these two from git-server-hooks building process
ARG COMMON_GROUP=nodegit
ARG COMMON_GROUP_GID=1002

ENV NODE_SERVER_DIR=/node-server
ENV START_SCRIPT_DIR=/init-scripts
ENV APP_DIRNAME=${APP_DIRNAME}
ENV APP_PORT=${APP_PORT}

WORKDIR ${START_SCRIPT_DIR}

COPY start.sh start.sh
RUN chown node start.sh
RUN chmod +x start.sh

EXPOSE ${APP_PORT}

# create a group which will have enough rights
# on the APP_DIR
RUN addgroup -g ${COMMON_GROUP_GID} ${COMMON_GROUP}
RUN addgroup node ${COMMON_GROUP}

# let builder check if build got the group right
# should output: <COMMON_GROUP>:x:<COMMMON_GROUP_GID>:node
RUN getent group ${COMMON_GROUP}

USER node

ENTRYPOINT ["sh", "-c", "${START_SCRIPT_DIR}/start.sh"]