#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "Usage: [version] [platform]"
fi

version=$1
platform=$2

if [[ $platform == "amd64" ]]; then
  echo "Installing linux/amd64"
  wget "https://github.com/neovim/neovim/releases/download/${version}/nvim-linux-x86_64.tar.gz"
  tar -C /opt -xzf nvim-linux-x86_64.tar.gz
elif [[ $platform == "arm64" ]]; then
  echo "Installing linux/arm64"
  wget "https://github.com/neovim/neovim/releases/download/${version}/nvim-linux-arm64.tar.gz"
  tar -C /opt -xzf nvim-linux-arm64.tar.gz
else
  echo "Unknown platform $platform"
  exit 1
fi
