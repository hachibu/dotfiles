#!/usr/bin/env bash

set -euo pipefail

count=5
threshold=3
dir="tmp"
secrets="$dir/secrets.txt"
input_file="$1"

rm -rf $dir
mkdir -p $dir

secret-share-split --count $count --threshold $threshold "$input_file" > $secrets

i=1
while IFS= read -r secret; do
  echo "$secret" | qrencode --output "$dir/secret-$i.png"
  i=$((i + 1))
done < $secrets

head -n $threshold "$secrets" | secret-share-combine
