#Requires AutoHotkey v2.0
CoordMode("Mouse", "Screen")

SetKeyDelay(10)
SetCapsLockState("AlwaysOff")

SetTrayIcon := (isActive) => TraySetIcon("shell32.dll", isActive ? 256 : 255)
SetTrayIcon(isActive := false)

;#REGION Caps-Lock Hero
;;;;;;;;;;;;;;;;;;
; # Caps-Lock Hero
; Long-press and repeated press functionality
;;;;;;;;;;;;;;;;;;
#Include "libCapsHero.ahk"
onKeyDown() {
  ToolTip()
  SetTrayIcon(isActive := true)
}
onKeyUp(repeats) {
  SetTrayIcon(isActive := false)

  switch (repeats) {
    case 2:  ; double-tap
      ;ToolTip("Double-Kill!")
      Send("{Alt down}{Space}{Alt up}")
      Sleep(25)
      Send("{BackSpace}")
    case 3:  ; triple-tap
      ;ToolTip("Triple-Kill!")
    case 4: ToolTip("Overkill!")
    case 5: ToolTip("Killtacular!")
    case 6: ToolTip("Killtrocity!")
    case 7: ToolTip("Killionaire!")
    case 8: ToolTip("Killtastrophe!")
    case 9: ToolTip("Killpocalypse!")
    case 10: ToolTip("Killionaire!")
    default:
      return Send("{Escape}")
  }
  SetTimer(ToolTip, 2000)
}
onKeyHold() {
  SetCapsLockState("AlwaysOff")
  ToolTip("Caps-Lock Long-press")
}
~CapsLock:: onHeroPress(onKeyDown, onKeyHold)
CapsLock up:: onHeroRepeatedPresses(onKeyUp)
;#ENDREGION

; show or hide LibreChat window
CapsLock & space:: {
  lc := "LibreChat"
  if WinActive(lc) { ; if app is focused then minimize it
    Send("{Alt down}{Tab}{Alt up}")
    return WinMinimize(lc)
  }
  WinActivate(lc) ; re-open window
  MouseGetPos(&pX, &pY)
  WinGetPos(&X, &Y, &Width, &Height, lc)
  Click(X + Width // 2, Y + Height - 50)
  MouseMove(pX, pY)
}
#t:: Run("wt.exe")  ; Open Terminal

; ## Shortcuts
^CapsLock:: Send("{Enter}") ; Ctrl + CapsLock to Press Enter
CapsLock & F5:: Reload()  ; Reload script
CapsLock & Enter:: MouseClick("Right")

; ### hjkl
CapsLock & h:: Send("{Left}")
CapsLock & j:: Send("{Down}")
CapsLock & k:: Send("{Up}")
CapsLock & l:: Send("{Right}")

; ### asdf
CapsLock & a:: Send("{Home}")
CapsLock & s:: Send("{BackSpace}")
CapsLock & d:: Send("{Delete}")
CapsLock & f:: Send("{End}")

; ### np
CapsLock & n:: Send("{Tab}")
CapsLock & p:: Send("+{Tab}")
CapsLock & i:: Send("{Escape}")
CapsLock & g:: Send("{AppsKey}")  ; Menu key

; ## Input Keyboard Shortcuts
; ### wb
CapsLock & w:: Send("{Ctrl Down}{Right}{Ctrl Up}")  ; word-forward
CapsLock & b:: Send("{Ctrl Down}{Left}{Ctrl Up}")   ; word-backward

; # Mouse Shortcuts
; ## movement
MouseMode := false
CapsLock & m:: global MouseMode := !MouseMode
#HotIf MouseMode
MouseToolTip := () => ToolTip("MOUSE MODE")
l:: MouseToolTip(), (MouseMove(50, 0, 5, "R"))
k:: MouseToolTip(), (MouseMove(0, -50, 5, "R"))
j:: MouseToolTip(), (MouseMove(0, 50, 5, "R"))
h:: MouseToolTip(), (MouseMove(-50, 0, 5, "R"))
u::Wheelup
d::WheelDown
Enter:: ToolTip(), MouseClick("Right")
.:: ToolTip(), MouseClick("Left")
m:: global MouseMode := false
#HotIf
; ## scrolling
CapsLock & PgUp::Wheelup
CapsLock & PgDn::WheelDown

; # G604 Logitech Mouse
; ## DPI Buttons
F19:: Send "{Media_Play_Pause}"
F20:: {
  Send "{LWin}"
  MouseGetPos , &y
  MouseMove 100, y
}
; ## Top row
F16:: Send "#4"
F17:: Send "#5"
F18:: Send "#6"
; ## Bottom row
F13:: Send "#1"
F14:: Send "#2"
F15:: Send "#3"

; # Auto-corrections
; ## Aliases
::d-c::docker-compose
::w-i::winget install
::w-s::winget search
; ## Typos
::adn::and
::awy::way
::aroudn::around
::withotu::without
::gonan::gonna
::teh::the
::hte::the
::serach::search
::usod::sudo
::suod::sudo
::netsatt::netstat
::sptoify::spotify
::eacohther::eachother
::throuhg::through
::seperate::separate
::firwmare::firmware
::dwonoad::download
::machien::machine
::uplaoded::uploaded
::tehme::theme
::wniget::winget
::ilke::like
::donig::doing
::pwoertoys::powertoys
::ont he::on the
::widht::width
::nkow::know
::bootstarp::bootstrap
::extnesions::extensions
::gamign::gaming
::tehre::there
::breakign::breaking
::functino::function
::hsift::shift
::mcd::cmd
::javascirpt::javascript
::epxort::export
::foucs::focus
::reddot::reddit
::wnidows::windows
::noe::one
::gonig::going
::beacuse::because
::wnidows::windows
::rael::real
::erver::server
::yotuube::youtube
::extneesion::extension
::supporitve::supportive
::ocmmands::commands
::ocmmand::command
::escap ekey::escape key
::highliht::highlight
::ot::to
::wiht::with
::insatll::install
::cap slcock::caps lock
::vesrion::version
::globla::global
::hting::thing
; ## Shortcuts
::;r::site:reddit.com
::;22::after:2022
::;23::after:2023
::;24::after:2024
::;sr::after:2022 site:reddit.com
ToolTip("Enhancements Loaded")
SetTimer(ToolTip, 1000)
