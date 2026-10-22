FROM alpine:3.24.3

# renovate: datasource=github-releases depName=jdx/mise
ARG MISE_VERSION="v2026.10.8"

RUN apk add curl ca-certificates

RUN curl https://mise.run | MISE_VERSION=${MISE_VERSION} MISE_INSTALL_PATH=/usr/local/bin/mise sh
