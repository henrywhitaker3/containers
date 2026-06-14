#!/bin/bash

PARENTS=()
CHILDREN=()

for dir in toolkit kubectl; do
  result=$(task version dir="$dir")
  if [ "$result" != "skip" ]; then
    entry=$(echo "$result" | jq -c --arg dir "$dir" '. + {dir: $dir}')
    PARENTS+=("$entry")
  fi
done
for dir in pipelines k6/statsd k6/disruptor; do
  result=$(task version dir="$dir")
  if [ "$result" != "skip" ]; then
    entry=$(echo "$result" | jq -c --arg dir "$dir" '. + {dir: $dir}')
    CHILDREN+=("$entry")
  fi
done

echo "parents=[$(
  IFS=,
  echo "${PARENTS[*]}"
)]"
echo "children=[$(
  IFS=,
  echo "${CHILDREN[*]}"
)]"
