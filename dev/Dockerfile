FROM ubuntu:24.04

# renovate: datasource=github-releases depName=getsops/sops
ARG SOPS_VERSION=v3.7.3
# renovate: datasource=github-releases depName=kubernetes-sigs/kustomize
ARG KUSTOMIZE_VERSION="v5.6.0"
# renovate: datasource=github-releases depName=homeport/dyff
ARG DYFF_VERSION="1.7.1"
# renovate: datasource=github-releases depName=helm/helm
ARG HELM_VERSION="v3.18.2"

RUN apt-get update && apt-get install -y gnupg software-properties-common wget git curl

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
