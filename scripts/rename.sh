#!/bin/bash

# 加入新图片时，对新图片重命名

directory="$1"
startNumber="$2"

cd "$directory" || exit

i=$startNumber
for file in *.png; do
  if [ -f "$file" ]; then
    newname="${i}.png"
    echo "$file -> $newname"
    mv -- "$file" "$newname"
    ((i++))
  fi
done