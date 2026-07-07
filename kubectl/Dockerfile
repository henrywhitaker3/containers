ARG BUILDARCH

FROM alpine:3.24.1

RUN apk add curl ca-certificates bash jq yq

WORKDIR /tmp

ARG BUILDARCH

# renovate: datasource=github-releases depName=kubernetes/kubernetes
ARG K8S_VERSION="v1.36.2"

RUN curl -LO "https://dl.k8s.io/release/${K8S_VERSION}/bin/linux/${BUILDARCH}/kubectl" \
    && mv kubectl /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl


WORKDIR /
