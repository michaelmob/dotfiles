#Requires AutoHotkey v2.0
#SingleInstance force
#WinActivateForce

ProcessSetPriority("High")
SetKeyDelay(10)
SendMode("Input")
ListLines(0)
KeyHistory(0)
SetControlDelay -1
CoordMode("Mouse", "Screen")
SetWorkingDir(A_ScriptDir)

#Include "./MikeEnhancements2/CapsLockBindings.ahk2"
#Include "./MikeEnhancements2/Launchers.ahk2"
#Include "./MikeEnhancements2/Scratchpads.ahk2"
#Include "./MikeEnhancements2/Desktops.ahk2"
#Include "./MikeEnhancements2/AliasesCorrections.ahk2"
#Include "./MikeEnhancements2/TrayMenu.ahk2"
#Include "./MikeEnhancements2/TrayIcon.ahk2"

ToolTip("Michael's Enhancements Loaded")
SetTimer(ToolTip, 5000)
