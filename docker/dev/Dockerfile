FROM node:14
SHELL ["/bin/bash", "-oeux", "pipefail", "-c"]

ARG project_name
ENV TZ=UTC \
    PROJECT_NAME=$project_name

RUN apt-get update && \
  apt-get install -y g++ build-essential

WORKDIR /work/app
