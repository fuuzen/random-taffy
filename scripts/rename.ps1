# 加入新图片时，对新图片重命名

param(
  [string]$directory,
  [int]$startNumber
)

$i = $startNumber
Get-ChildItem -Path $directory -Filter "*.png" | 
  Sort-Object Name | 
  ForEach-Object {
    Rename-Item -Path $_.FullName -NewName "$i.png"
    $i++
  }