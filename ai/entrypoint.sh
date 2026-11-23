#!/bin/sh
set -eu

runtime_uid="$(id -u)"
runtime_gid="$(id -g)"

runtime_mise_dir="/tmp/mise-${runtime_uid}-${runtime_gid}"
runtime_xdg_dir="/tmp/xdg-${runtime_uid}-${runtime_gid}"

mkdir -p "$runtime_mise_dir/cache" "$runtime_mise_dir/state"
mkdir -p "$runtime_xdg_dir/cache" "$runtime_xdg_dir/state"

export MISE_CACHE_DIR="$runtime_mise_dir/cache"
export MISE_STATE_DIR="$runtime_mise_dir/state"
export XDG_CACHE_HOME="$runtime_xdg_dir/cache"
export XDG_STATE_HOME="$runtime_xdg_dir/state"

exec "$@"
