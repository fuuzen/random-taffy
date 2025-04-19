#!/bin/bash

# 对原始图片缩放

directory=$1
scaleFactor=$2

cd "${directory}" || exit

target_dir="../${directory}_${scaleFactor}"
mkdir -p "$target_dir" || exit

shopt -s nullglob
images=(*.jpg *.png *.jpeg)
total=${#images[@]}
processed=0

for img in "${images[@]}"; do
  ((processed++))
  
  # 计算进度百分比
  percent=$((100*processed/total))
  
  # 绘制进度条
  bar_length=50
  filled=$((bar_length*percent/100))
  bar=$(printf "%${filled}s" | tr ' ' '=')
  empty=$(printf "%$((bar_length-filled))s")
  
  # 显示进度信息
  printf "\r[%-${bar_length}s] %3d%% Processing: %s" "${bar}${empty}" "$percent" "$img"
  
  # 执行缩放 (完全静默模式)
  ffmpeg -hide_banner -loglevel error -i "$img" \
         -vf "scale=iw*${scaleFactor}:ih*${scaleFactor}" \
         "$target_dir/$img" 2>/dev/null
done

cd ..