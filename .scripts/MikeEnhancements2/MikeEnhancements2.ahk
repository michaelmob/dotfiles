#Requires AutoHotkey v2.0
#SingleInstance force
#WinActivateForce

ProcessSetPriority("High")
SetKeyDelay(10)
SendMode("Input")
ListLines(0)
SetControlDelay(-1)
CoordMode("Mouse", "Screen")
DetectHiddenWindows(true)
;SetWorkingDir(A_ScriptDir)
KeyHistory(3)

;

#Include "./Desktops.ahk2"
#Include "./HyperBindings.ahk2"
#Include "./RightCtrl.ahk2"
#Include "./Launchers.ahk2"
#Include "./Scratchpads.ahk2"

#Include "./Hotstrings.ahk2"
#Include "./Menu.ahk2"
#Include "./Icon.ahk2"

#Include "./test.ahk2"

;

ToolTip("MikeEnhancements2 loaded")
SetTimer(ToolTip, 3000)
