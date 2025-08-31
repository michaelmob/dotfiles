# Description: Download lilnasy's automated builds of Zed to ~/Apps
# Author: github.com/michaelmob
# Last Updated: 2025-03-06
$fileName = if ($args.Count -gt 0) { $args[0] } else { "zed.exe" }

$zedLatest = Invoke-RestMethod -Uri "https://api.github.com/repos/lilnasy/zed-windows-builds/releases/latest"
$downloadUrl = $zedLatest.assets |
    Where-Object { $_.name -like $fileName } |
    Select-Object -ExpandProperty browser_download_url -First 1

$appsPath = Join-Path -Path $env:USERPROFILE -ChildPath "Apps"
if (-not (Test-Path -Path $appsPath)) {
    New-Item -ItemType Directory -Path $appsPath
}
$outFile = Join-Path -Path $appsPath -ChildPath (Split-Path -Leaf $downloadUrl)

Invoke-WebRequest -Uri $downloadUrl -OutFile $outFile
Start-Process -FilePath $outFile -NoNewWindow