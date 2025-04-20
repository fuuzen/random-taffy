#!/bin/bash

# 对图片进行 chafa 色块转换

directory=$1

cd "${directory}" || exit

target_dir="../${directory}_chafa"
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
  printf "\r[%-${bar_length}s] %3d%% Processing: %s" "${bar}${empty}" "${percent}" "${img}"
  
  # 转化为 chafa 色块
  chafa "${img}" -f symbols -s 50 > "${target_dir}/${img}.chafa"
done

cd ..