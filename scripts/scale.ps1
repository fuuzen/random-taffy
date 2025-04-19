# 对原始图片缩放

param(
  [string]$directory,
  [float]$scaleFactor
)

# 进入目录，如果失败则退出
try {
  Set-Location -Path $directory -ErrorAction Stop
}
catch {
  Write-Error "无法进入目录: $directory"
  exit 1
}

# 创建目标目录
$targetDir = "../${directory}_$scaleFactor"
New-Item -ItemType Directory -Path $targetDir -Force | Out-Null

$imageFiles = Get-ChildItem -Path $sourceDir
$totalFiles = $imageFiles.Count
$processedFiles = 0

# 处理所有图片文件
$imageFiles | ForEach-Object {
  $inputFile = $_.FullName
  $outputFile = Join-Path -Path $targetDir -ChildPath $_.Name
  
  $progress = [math]::Round(($processedFiles / $totalFiles) * 100)
  Write-Progress -Activity "Processing: " -Status "$progress%" `
    -PercentComplete $progress
  
  # 使用 ffmpeg 缩放图片
  ffmpeg -i "`"$inputFile`"" -vf "scale=iw*${scaleFactor}:ih*${scaleFactor}" "`"$outputFile`""  2>&1 > $null

  $processedFiles++
}

cd ..