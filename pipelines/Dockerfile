FROM ghcr.io/henrywhitaker3/containers/toolkit:latest

ARG USER=abc

ENV HOME=/home/$USER
ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color

RUN apk add openssh rsync age python3 py3-pip kdb

RUN adduser --home "$HOME" --shell /bin/bash --disabled-password --gecos '' "$USER"

RUN mkdir "$HOME/.ssh" && \
  chmod 700 "$HOME/.ssh" && \
  chown "$USER":"$USER" "$HOME/.ssh"

USER $USER

ENV PATH="$HOME/.local/bin:$PATH"
RUN pip3 install --break-system-packages ansible ansible-lint

WORKDIR $HOME
