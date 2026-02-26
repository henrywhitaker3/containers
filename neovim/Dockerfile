FROM ubuntu:24.04

RUN apt update && apt install -y git \
    stow \
    zsh \
    wget \
    curl \
    build-essential \
    procps \
    file \
    git \
    sudo

ARG USER=abc
ENV HOME=/home/$USER
ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color

RUN adduser --home "$HOME" --shell /bin/zsh --disabled-password --gecos '' "$USER"

RUN mkdir "$HOME/.ssh" && \
    chmod 700 "$HOME/.ssh" && \
    chown "$USER":"$USER" "$HOME/.ssh" && \
    mkdir -p /etc/sudoers.d/ && \
    echo "$USER ALL=(ALL) NOPASSWD:ALL" >> "/etc/sudoers.d/99-$USER"

USER $USER

WORKDIR $HOME

RUN git clone https://github.com/henrywhitaker3/dotfiles.git && \
    rm "$HOME/.bashrc" || true && \
    rm "$HOME/.zshrc" || true && \
    cd dotfiles && ./linux/init.sh && \
    "$HOME/.local/bin/task" linux:stow && \
    "$HOME/.local/bin/task" linux

RUN /home/linuxbrew/.linuxbrew/bin/nvim --headless "+Lazy! restore" "+MasonToolsInstallSync" +qa

ENTRYPOINT ["/bin/zsh"]
