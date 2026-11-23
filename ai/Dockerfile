FROM ghcr.io/henrywhitaker3/containers/mise:v1.5.1

ENV HOME=/home/codex \
    CODEX_HOME=/home/codex/.codex \
    PATH="/home/codex/.local/share/mise/shims:${PATH}"

RUN apk add --no-cache libgcc libstdc++ bash && \
    adduser -D -u 1000 -s /bin/bash codex && \
    mkdir -p /workspace && \
    chown codex:codex /workspace

COPY --chown=codex:codex mise.toml /home/codex/.config/mise/config.toml
COPY entrypoint.sh /usr/local/bin/entrypoint

RUN chmod 755 /usr/local/bin/entrypoint

USER codex

RUN mise bootstrap && \
    mise reshim && \
    chmod -R a+rwX /home/codex/.local/share/mise

ENTRYPOINT ["/usr/local/bin/entrypoint"]

CMD ["bash"]

WORKDIR /workspace
