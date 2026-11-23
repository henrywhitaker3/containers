FROM ghcr.io/henrywhitaker3/containers/mise:v1.5.0

COPY mise.toml /root/.config/mise/config.toml

ENV PATH="/root/.local/share/mise/shims:${PATH}"

RUN apk add --no-cache libgcc libstdc++ bash && \
    mise bootstrap && \
    mise reshim
