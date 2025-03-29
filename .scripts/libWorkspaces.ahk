#Include "libVD.ahk"

SwitchDesktopRelative(num) {
  if (Abs(num) == 1)
    Send("{LCtrl Down}{LWin Down}{" . (num == 1 ? "Righ" : "Lef") . "t}{LWin Up}{LCtrl Up}")
}

SwitchDesktop(num) {
  if (VD.getCount() < num)
    return

  diff := num - VD.getCurrentDesktopNum()
  if (Abs(diff) == 1)
    return SwitchDesktopRelative(diff)

  VD.goToDesktopNum(num)
}
