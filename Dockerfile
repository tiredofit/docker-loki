FROM docker.io/tiredofit/nginx:alpine-3.16
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ENV LOKI_VERSION=v2.6.1 \
    NGINX_SITE_ENABLED=loki \
    IMAGE_NAME="tiredofit/loki" \
    IMAGE_REPO_URL="https://github.com/tiredofit/docker-loki/"

RUN set -x && \
    apk update && \
    apk upgrade && \
    apk add -t .loki-build-deps \
               git \
               go \
               && \
    \
    git clone https://github.com/grafana/loki /usr/src/loki && \
    cd /usr/src/loki && \
    git checkout ${LOKI_VERSION} && \
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
ADD install /
