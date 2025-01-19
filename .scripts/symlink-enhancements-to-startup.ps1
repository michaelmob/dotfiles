$fileName = "MikeEnhancements2.ahk"
$srcPath = Join-Path -Path $HOME -ChildPath ".scripts\$fileName"

$shellStartup = [Environment]::GetFolderPath("Startup")
$destPath = Join-Path -Path $shellStartup -ChildPath "$fileName.lnk"

$shell = New-Object -ComObject WScript.Shell

$shortcut = $shell.CreateShortcut($destPath)
$shortcut.TargetPath = $srcPath
$shortcut.Save()
