FROM tiredofit/nginx:alpine-3.14
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ENV LOKI_VERSION=2.3.0

RUN set -x && \
    apk update && \
    apk upgrade && \
    apkArch="$(apk --print-arch)" && \
    case "$apkArch" in \
        x86_64) lokiArch='amd64' ;; \
        armv7) lokiArch='arm' ;; \
        armhf) lokiArch='arm' ;; \
        aarch64) lokiArch='arm64' ;; \
        *) echo >&2 "Error: unsupported architecture ($apkArch)"; exit 1 ;; \
    esac; \
    curl -sS -o /usr/src/loki.zip -L https://github.com/grafana/loki/releases/download/v${LOKI_VERSION}/loki-linux-${lokiArch}.zip && \
    cd /usr/src && \
    unzip -d . loki.zip && \
    chmod +x loki-linux-${lokiArch} && \
    mv loki-linux-${lokiArch} /usr/sbin/loki && \
    # Cleanup
    rm -rf /usr/src/* && \
    rm -rf /tmp/* /var/cache/apk/*

### Add Files and Assets
ADD install /
