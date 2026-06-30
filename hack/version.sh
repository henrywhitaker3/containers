#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "Usage: version.sh [dir]"
fi

dir=$1
sanitised=$(echo "$dir" | tr '/' '-')

output=$(git cliff --include-path "$dir/*" --tag-pattern "$sanitised-v.*" --bump --unreleased --context)
skip="false"
changelog=$(git cliff --include-path "$dir/*" --tag-pattern "$sanitised.*" --bump)

if [[ $(echo "$output" | jq -r '.[0].bump_type') == "null" ]]; then
  skip="true"
fi

tag=$(echo "$output" | jq -r '.[0].version // "bongo"')
version=${tag#"$sanitised-"}

jq -n \
  --arg tag "$tag" \
  --arg version "$version" \
  --arg changelog "$changelog" \
  --arg skip "$skip" \
  '{"tag": $tag, "version": $version, "changelog": $changelog, "skip": $skip | test("true")}'
