ARG DISTRO="alpine"
ARG DISTRO_VARIANT="3.17"

FROM docker.io/tiredofit/nginx:${DISTRO}-${DISTRO_VARIANT}
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ARG LOKI_VERSION

ENV LOKI_VERSION=${LOKI_VERSION:-"v2.8.2"} \
    NGINX_SITE_ENABLED=loki \
    NGINX_ENABLE_CREATE_SAMPLE_HTML=FALSE \
    NGINX_WORKER_PROCESSES=1 \
    IMAGE_NAME="tiredofit/loki" \
    IMAGE_REPO_URL="https://github.com/tiredofit/docker-loki/"

RUN source /assets/functions/00-container && \
    set -x && \
    package update && \
    package upgrade && \
    package install .loki-build-deps \
               git \
               go \
               && \
    \
    clone_git_repo https://github.com/grafana/loki ${LOKI_VERSION} && \
    go build ./cmd/logcli && \
    mv logcli /usr/sbin && \
    go build ./cmd/loki && \
    mv loki /usr/sbin && \
    go build ./cmd/loki-canary && \
    mv loki-canary /usr/sbin && \
    package remove .loki-build-deps && \
    package cleanup && \
    rm -rf /root/.cache \
           /tmp/*

COPY install /
