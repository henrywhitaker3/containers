ARG BUILDARCH

FROM alpine:3.22.1

RUN apk add curl ca-certificates bash

WORKDIR /tmp

ARG BUILDARCH

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/${BUILDARCH}/kubectl" \
    && mv kubectl /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

WORKDIR /
