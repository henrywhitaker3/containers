FROM alpine:3.22.1 AS neovim

# renovate: datasource=github-releases depName=neovim/neovim
ARG NEOVIM_VERSION=v0.11.5

RUN apk add autoconf automake cmake curl g++ git gettext gettext-dev libtool \
    make ninja openssl pkgconfig unzip binutils wget

RUN git clone https://github.com/neovim/neovim.git /tmp/neovim && \
    cd /tmp/neovim && \
    git fetch --all --tags -f && \
    git checkout ${NEOVIM_VERSION} && \
    make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=/usr/local/ && \
    make install && \
    strip /usr/local/bin/nvim

FROM ghcr.io/henrywhitaker3/containers/toolkit:latest

# renovate: datasource=github-releases depName=ahmetb/kubectx
ARG KUBECTX_VERSION=v0.9.5
# renovate: datasource=github-releases depName=junegunn/fzf
ARG FZF_VERSION=0.65.1
# renovate: datasource=github-tags depName=golang/go
ARG GO_VERSION=go1.25.0

RUN apk add stow zsh build-base python3 py3-pip \
    py3-virtualenv lua5.4 lua5.4-dev luajit luarocks \
    ripgrep nodejs npm openssh stylua lua-language-server

RUN ln -s /usr/bin/lua5.4 /usr/bin/lua
RUN ln -s /usr/bin/luarocks-5.4 /usr/bin/luarocks

ARG BUILDARCH

WORKDIR /tmp

COPY ./install_kubectx.sh .
RUN chmod +x install_kubectx.sh && ./install_kubectx.sh ${KUBECTX_VERSION} ${BUILDARCH}

RUN wget https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz \
    -O fzf.tar.gz && \
    tar -xzvf fzf.tar.gz && \
    mv fzf /usr/local/bin

COPY --from=neovim /usr/local /usr/local/
COPY --from=neovim /lib/ld-musl-* /lib/
COPY --from=neovim /usr/lib/libgcc_s.so.1 /usr/lib/
COPY --from=neovim /usr/lib/libintl.so.8 /usr/lib/

RUN wget https://go.dev/dl/${GO_VERSION}.linux-${BUILDARCH}.tar.gz && \ 
    rm -rf /usr/local/go && tar -C /usr/local -xzf "${GO_VERSION}.linux-${BUILDARCH}.tar.gz"

ARG USER=abc
ENV HOME=/home/$USER
ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color

RUN adduser --home "$HOME" --shell /bin/zsh --disabled-password --gecos '' "$USER"

RUN mkdir "$HOME/.ssh" && \
    chmod 700 "$HOME/.ssh" && \
    chown "$USER":"$USER" "$HOME/.ssh"

USER $USER

ENV PATH="$HOME/.cargo/bin:/usr/local/go/bin:/opts/nvim-linux-x86_64/bin:/opt/nvim-linux-arm64/bin:/home/abc/.local/bin:$PATH"

WORKDIR $HOME

RUN curl https://sh.rustup.rs -sSf | bash -s -- -y && \
    rustup component add rust-analyzer && \
    rustup component add rustfmt

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

RUN git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.zsh/zsh-autosuggestions"
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting "$HOME/.zsh/zsh-syntax-highlighting"
RUN git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

RUN git clone https://github.com/henrywhitaker3/dotfiles.git && \
    cd dotfiles && rm "$HOME/.bashrc" || true && rm "$HOME/.zshrc" || true && task linux:stow

RUN nvim --headless "+Lazy! restore" "+MasonToolsInstallSync" +qa
