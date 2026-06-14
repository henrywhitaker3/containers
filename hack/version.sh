#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "Usage: version.sh [dir]"
fi

dir=$1
sanitised=$(echo "$dir" | tr '/' '-')

echo "$dir -> $sanitised"

output=$(git cliff --include-path "$dir/*" --tag-pattern "$sanitised-v.*" --bump --unreleased --context)

if [[ $(echo "$output" | jq -r '.[0].bump_type') == "null" ]]; then
  echo "skip"
  exit 0
fi

git cliff --include-path "$dir/*" --tag-pattern "$sanitised.*" --bump >"$dir/CHANGELOG.md"

tag=$(echo "$output" | jq -r '.[0].version')
version=${tag#"$sanitised-"}

jq -n \
  --arg tag "$tag" \
  --arg version "$version" \
  '{"tag": $tag, "version": $version}'
