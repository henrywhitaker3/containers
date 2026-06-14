FROM golang:1.26.4 AS builder

# renovate: datasource=github-releases depName=grafana/k6
ARG XK6_VERSION="v1.4.6"

# renovate: datasource=github-releases depName=LeonAdato/xk6-output-statsd
ARG K6_STATSD_VERSION="0.3.0"

RUN go install go.k6.io/xk6/cmd/xk6@${XK6_VERSION}

RUN xk6 build \
    --with github.com/LeonAdato/xk6-output-statsd@${K6_STATSD_VERSION} \
    --output /k6

FROM grafana/k6:latest
COPY --from=builder /k6 /usr/bin/k6
