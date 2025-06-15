FROM ubuntu:24.04

# renovate: datasource=github-releases depName=getsops/sops
ARG SOPS_VERSION=v3.10.2
# renovate: datasource=github-releases depName=kubernetes-sigs/kustomize
ARG KUSTOMIZE_VERSION=v5.6.0
# renovate: datasource=github-releases depName=homeport/dyff
ARG DYFF_VERSION=1.10.1
# renovate: datasource=github-releases depName=helm/helm
ARG HELM_VERSION=v3.18.2
# renovate: datasource=github-releases depName=ahmetb/kubectx
ARG KUBECTX_VERSION=v0.9.5
# renovate: datasource=github-releases depName=junegunn/fzf
ARG FZF_VERSION=0.62.0
# renovate: datasource=github-releases depName=neovim/neovim
ARG NEOVIM_VERSION=v0.11.2
# renovate: datasource=github-tags depName=golang/go
ARG GO_VERSION=go1.24.4

RUN apt-get update && apt-get install -y gnupg \
  software-properties-common \
  wget \
  git \
  curl \
  stow \
  zsh \
  build-essential \
  python3 \
  python3-pip \
  python3-venv \
  lua5.4 \
  lua5.4-dev \
  luajit \
  luarocks \
  ripgrep

ARG BUILDARCH

WORKDIR /tmp

RUN wget https://get.helm.sh/helm-${HELM_VERSION}-linux-${BUILDARCH}.tar.gz -O helm.tar.gz && \
  tar -xzvf helm.tar.gz && \
  mv "linux-${BUILDARCH}/helm" /usr/local/bin

RUN wget https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_${BUILDARCH}.tar.gz \
  -O kustomize.tar.gz && \
  tar -xzvf kustomize.tar.gz && \
  mv kustomize /usr/local/bin

RUN wget https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux.${BUILDARCH} -O /usr/local/bin/sops \
  && chmod 0755 /usr/local/bin/sops \
  && chown root:root /usr/local/bin/sops

RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/${BUILDARCH}/kubectl" \
  && mv kubectl /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl

RUN wget https://github.com/homeport/dyff/releases/download/v${DYFF_VERSION}/dyff_${DYFF_VERSION}_linux_${BUILDARCH}.tar.gz \
  && tar -xzvf dyff_${DYFF_VERSION}_linux_${BUILDARCH}.tar.gz \
  && mv dyff /usr/local/bin

RUN wget https://github.com/ahmetb/kubectx/releases/download/${KUBECTX_VERSION}/kubectx_${KUBECTX_VERSION}_linux_${BUILDARCH}.tar.gz \
  -O kubectx.tar.gz && \
  tar -xzvf kubectx.tar.gz && \
  mv kubectx /usr/local/bin

RUN wget https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz \
  -O fzf.tar.gz && \
  tar -xzvf fzf.tar.gz && \
  mv fzf /usr/local/bin

COPY ./install_nvim.sh .
RUN chmod +x install_nvim.sh && ./install_nvim.sh "$NEOVIM_VERSION" "${BUILDARCH}"

RUN wget https://go.dev/dl/${GO_VERSION}.linux-${BUILDARCH}.tar.gz && \ 
  rm -rf /usr/local/go && tar -C /usr/local -xzf "${GO_VERSION}.linux-${BUILDARCH}.tar.gz"

RUN curl -sL https://deb.nodesource.com/setup_24.x | bash - 
RUN apt-get install -y nodejs

ARG USER=abc
ENV HOME=/home/$USER
ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color

RUN adduser --home "$HOME" --shell /bin/zsh --disabled-password --gecos '' "$USER"

RUN mkdir "$HOME/.ssh" && \
  chmod 700 "$HOME/.ssh" && \
  chown "$USER":"$USER" "$HOME/.ssh"

USER $USER

ENV PATH="/home/abc/.local/bin:$PATH"

WORKDIR $HOME

RUN curl https://sh.rustup.rs -sSf | bash -s -- -y && \
  PATH="$PATH:$HOME/.cargo/bin" rustup component add rust-analyzer && \
  PATH="$PATH:$HOME/.cargo/bin" rustup component add rustfmt

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

RUN git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.zsh/zsh-autosuggestions"
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting "$HOME/.zsh/zsh-syntax-highlighting"
RUN git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

RUN git clone https://github.com/henrywhitaker3/dotfiles.git && \
  cd dotfiles && rm "$HOME/.bashrc" && rm "$HOME/.zshrc" && task linux:stow

RUN PATH="$PATH:/opt/nvim-linux-x86_64/bin:/opt/nvim-linux-arm64/bin:$HOME/.cargo/bin:/usr/local/go/bin" \
  nvim --headless "+Lazy! restore" "+MasonToolsInstallSync" +qa
