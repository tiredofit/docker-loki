ARG DISTRO="alpine"
ARG DISTRO_VARIANT="edge"

FROM docker.io/tiredofit/nginx:${DISTRO}-${DISTRO_VARIANT}
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ARG LOKI_VERSION

ENV LOKI_VERSION=${LOKI_VERSION:-"v3.4.2"} \
    NGINX_SITE_ENABLED=loki \
    NGINX_CLIENT_BODY_BUFFER_SIZE=2M \
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
    go build -ldflags='-s -w' ./cmd/logcli && \
    go build -ldflags='-s -w' ./cmd/loki && \
    go build -ldflags='-s -w' ./cmd/loki-canary && \
    mv \
             logcli \
             loki \
             loki-canary \  
        /usr/local/bin && \
    package remove .loki-build-deps && \
    package cleanup && \
    rm -rf \
           /root/.cache \
           /tmp/*

COPY install /
