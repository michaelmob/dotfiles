$projectName = "MikeEnhancements2"

$srcPath = Join-Path -Path $HOME -ChildPath ".scripts\$projectName\$projectName.ahk"
$shellStartup = [Environment]::GetFolderPath("Startup")
$destPath = Join-Path -Path $shellStartup -ChildPath "$projectName.lnk"
$shell = New-Object -ComObject WScript.Shell

$shortcut = $shell.CreateShortcut($destPath)
$shortcut.TargetPath = $srcPath
$shortcut.Save()
