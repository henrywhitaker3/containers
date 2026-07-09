FROM alpine:3.24.1

# renovate: datasource=github-releases depName=jdx/mise
ARG MISE_VERSION="v2026.7.4"

ARG BUILDARCH

RUN apk add curl ca-certificates

RUN curl -L https://github.com/jdx/mise/releases/download/${MISE_VERSION}/mise-${MISE_VERSION}-${BUILDARCH} > /usr/local/bin/mise \
    && chmod +x /usr/local/bin/mise
