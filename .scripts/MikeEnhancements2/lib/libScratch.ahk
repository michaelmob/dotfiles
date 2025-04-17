scratchPad(wintitle, exe := "", action := "PULL") {
  ; if (!ProcessExist(SplitPath(exe)))
  ;   Run(exe)

  if WinActive(wintitle) {
    if (VD.getCurrentDesktopNum() == 1)
      WinMinimize(wintitle)
    else
      VD.getCount() >= 1 && VD.MoveWindowToDesktopNum(wintitle, 1)  ; move to desktop 1
  }
  else if action == "PULL"
    if VD.MoveWindowToCurrentDesktop(wintitle)
      Run(exe)
  else if action == "GOTO"
    VD.goToDesktopOfWindow(wintitle)
  else if (WinExist(wintitle))
    WinActivate(wintitle)
}
