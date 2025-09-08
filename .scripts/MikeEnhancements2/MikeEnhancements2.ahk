#Requires AutoHotkey v2.0
#SingleInstance force
#WinActivateForce

;SetWorkingDir(A_ScriptDir)
SendMode("Input")
CoordMode("Mouse", "Screen")
ProcessSetPriority("High")
DetectHiddenWindows(true)
SetKeyDelay(10)
SetControlDelay(-1)
KeyHistory(3)
ListLines(0)

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
