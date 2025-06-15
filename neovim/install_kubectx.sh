#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "Usage: [version] [platform]"
fi

version=$1
platform=$2

if [[ $platform == "amd64" ]]; then
  echo "Installing linux/amd64"
  wget -O kubectx.tar.gz "https://github.com/ahmetb/kubectx/releases/download/${version}/kubectx_${version}_linux_x86_64.tar.gz"
elif [[ $platform == "arm64" ]]; then
  echo "Installing linux/arm64"
  wget -O kubectx.tar.gz "https://github.com/ahmetb/kubectx/releases/download/${version}/kubectx_${version}_linux_arm64.tar.gz"
else
  echo "Unknown platform $platform"
  exit 1
fi

tar -xzvf kubectx.tar.gz
md kubectx /usr/local/bin
