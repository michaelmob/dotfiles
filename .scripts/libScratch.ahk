scratchPad(wintitle, exe := "", action := "PULL") {
  ; if window doesn't then exist run it
  ; if app is focused then minimize it
  if WinActive(wintitle) {
    ;MsgBox(3)
    Send("{Alt down}{Tab}{Alt up}") ; switch back to previous window
    WinMinimize(wintitle) ; and minimize
  }
  ; or just try moving it to our desktop
  else if action == "PULL" {
    ;MsgBox(4)
    VD.MoveWindowToCurrentDesktop(wintitle)
  }
  ; go to window's desktop
  else if action == "GOTO" {
    ;MsgBox(5)
    VD.goToDesktopOfWindow(wintitle)
  }
  else if (WinExist(wintitle)) {
    WinActivate(wintitle)
  }
  ; else if (WinExist) {
  ;   ;MsgBox(6)
  ;   WinActivate(wintitle)
  ; }

  ; if (!WinExist(wintitle)) {
  ;   if (exe != "")
  ;     return Run(exe)
  ; }
}
