FROM docker.io/tiredofit/nginx:alpine-3.16
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ENV LOKI_VERSION=v2.7.0 \
    NGINX_SITE_ENABLED=loki \
    IMAGE_NAME="tiredofit/loki" \
    IMAGE_REPO_URL="https://github.com/tiredofit/docker-loki/"

RUN source /assets/functions/00-container && \
    set -x && \
    apk update && \
    apk upgrade && \
    apk add -t .loki-build-deps \
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
    \
    # Cleanup
    apk del .loki-build-deps && \
    rm -rf /usr/src/* && \
    rm -rf /root/.cache /tmp/* /var/cache/apk/*

### Add Files and Assets
COPY install /
