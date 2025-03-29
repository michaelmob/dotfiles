#Requires AutoHotkey v2.0
#SingleInstance force
#WinActivateForce
ListLines 0
SendMode "Input"
SetWorkingDir A_ScriptDir
KeyHistory 0
ProcessSetPriority "H"
SetWinDelay -1
SetControlDelay -1
CoordMode("Mouse", "Screen")
SetKeyDelay(10)
SetCapsLockState("AlwaysOff")


;#REGION Tray Icon
;;;;;;;;;;;;;;
; # Tray Icon
;;;;;;;;;;;;;;
SetTrayIcon := (isActive) => TraySetIcon("shell32.dll", isActive ? 256 : 255)
SetTrayIcon(isActive := false)

A_TrayMenu.Delete()
A_TrayMenu.Add("ShareX: Clipboard Viewer", (*) => Run("C:\Program Files\ShareX\ShareX.exe -ClipboardViewer"))
A_TrayMenu.Add("ShareX: Color Picker", (*) => Run("C:\Program Files\ShareX\ShareX.exe -ScreenColorPicker"))

A_TrayMenu.Add()
A_TrayMenu.AddStandard() ;("Reload", (*) => Reload())
;;;;;;;;;;;;;
;#ENDREGION


;#REGION Hero Key
;;;;;;;;;;;;;;;;;;;
; # Hero Key
; Long-press and repeated key-press functionality
;;;;;;;;;;;;;;;;;;;
#Include "libHeroKey.ahk"
onHeroKeyDown() {
  SetCapsLockState("AlwaysOff")
  SetTrayIcon(isActive := true)
}
onHeroKeyUp(repeatedPresses) {
  SetCapsLockState("AlwaysOff")
  SetTrayIcon(isActive := false)

  if (ProcessExist("ModeBox.exe"))
    ProcessClose("ModeBox.exe")
  global Mode := "NORMAL"

  switch (repeatedPresses) {
    case 2:
      Send("{Escape}")
      ToolTip("Double-Kill!")
    case 3: ToolTip("Triple-Kill!")
    case 4: ToolTip("Overkill!")
    case 5: ToolTip("Killtacular!")
    case 6: ToolTip("Killtrocity!")
    case 7: ToolTip("Killionaire!")
    case 8: ToolTip("Killtastrophe!")
    case 9: ToolTip("Killpocalypse!")
    case 10: ToolTip("Killionaire!")
    default: Send("{Escape}")
  }
}
onHeroKeyHold() {
  SetCapsLockState("AlwaysOff")
  ToolTip("Hero Key held for " . HERO_HOLD_MS . "ms")
  return false ; block key-up event
}
~CapsLock:: onHeroKeyPress(onHeroKeyDown, onHeroKeyHold)
CapsLock up:: onHeroKeyRepeatedPresses(onHeroKeyUp)
;;;;;;;;;;;;;;;;;;;
;#ENDREGION


;#REGION Scratchpads
#Include "libScratch.ahk"
CapsLock & space::
CapsLock & q:: {
  lc := "LibreChat"
  scratchPad(lc)

  MouseGetPos(&pX, &pY)
  WinGetPos(&X, &Y, &Width, &Height, lc)
  Click(X + Width // 2, Y + Height - 50)
  MouseMove(pX, pY)
}

CapsLock & r:: scratchPad("ahk_exe mstsc.exe", "PULL")  ; Remote Desktop
CapsLock & t:: scratchPad("ahk_exe WindowsTerminal.exe", "wt.exe", "GOTO")  ; 1=goto Remote Desktop
CapsLock & w:: scratchPad("ahk_exe brave.exe", "brave.exe", "GOTO")  ; 1=goto Browser
CapsLock & e:: scratchPad("ahk_exe Code.exe", "", "NULL")  ; -1=nothing VSCode

;;;;;;;;;;;;;;;;;;;
;#ENDREGION


;#REGION Caps-Lock Keybinds
; show or hide LibreChat window
; ### Shortcuts
^CapsLock:: Send("{Enter}") ; Ctrl + CapsLock to Press Enter
CapsLock & F5:: Reload()  ; Reload script

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
;CapsLock & w:: Send("{Ctrl Down}{Right}{Ctrl Up}")  ; word-forward
;CapsLock & b:: Send("{Ctrl Down}{Left}{Ctrl Up}")   ; word-backward

; ## PowerToys Launcher
CapsLock & Tab:: {
  Send("{Alt Down}{Space}{Alt Up}")
  Sleep(10)
  Send("<")
}

; ## Workspaces
#Include "libVD.ahk"  ; https://github.com/FuPeiJiang/VD.ahk/tree/v2_port
#Include "libWorkspaces.ahk"
; ### Focus relative desktop direction
CapsLock & .:: SwitchDesktopRelative(1)
CapsLock & ,:: SwitchDesktopRelative(-1)

; ### Focus desktop, CapsLock + {1,2,3,4,5,6,7,8,9}
CapsLock & 1:: SwitchDesktop(1)
CapsLock & 2:: SwitchDesktop(2)
CapsLock & 3:: SwitchDesktop(3)
CapsLock & 4:: SwitchDesktop(4)
CapsLock & 5:: SwitchDesktop(5)
CapsLock & 6:: SwitchDesktop(6)
CapsLock & 7:: SwitchDesktop(7)
CapsLock & 8:: SwitchDesktop(8)
CapsLock & 9:: SwitchDesktop(9)

; ### Move window to desktop, Win + Shift + {1,2,3,4,5,6,7,8,9}
!#1:: VD.getCount() >= 1 && VD.MoveWindowToDesktopNum("A", 1).follow()
!#2:: VD.getCount() >= 2 && VD.MoveWindowToDesktopNum("A", 2).follow()
!#3:: VD.getCount() >= 3 && VD.MoveWindowToDesktopNum("A", 3).follow()
!#4:: VD.getCount() >= 4 && VD.MoveWindowToDesktopNum("A", 4).follow()
!#5:: VD.getCount() >= 5 && VD.MoveWindowToDesktopNum("A", 5).follow()
!#6:: VD.getCount() >= 6 && VD.MoveWindowToDesktopNum("A", 6).follow()
!#7:: VD.getCount() >= 7 && VD.MoveWindowToDesktopNum("A", 7).follow()
!#8:: VD.getCount() >= 8 && VD.MoveWindowToDesktopNum("A", 8).follow()
!#9:: VD.getCount() >= 9 && VD.MoveWindowToDesktopNum("A", 9).follow()
;#ENDREGION


;#REGION Software Rebinds
#t:: {
  Sleep(150)
  Run("wt.exe")
} ; Open terminal
+#t:: Run("*RunAs wt.exe")  ; Open elevated terminal
^+4:: Send("{Ctrl Down}{PrintScreen}{Ctrl Up}")  ; # Ctrl + Shift + 4 to capture a region with ShareX
;#ENDREGION

;#REGION Modes
;## movement
Mode := "NORMAL"
CapsLock & m:: {
  global Mode
  if (Mode == "NORMAL") {
    Mode := "MOUSE"
    Run("ModeBox.exe -Text MOUSE MODE -BorderSize 2")
  }
  else if (Mode != "NORMAL") {
    Mode := "NORMAL"
  }
}

#HotIf Mode == "MOUSE"
h:: MouseMove(-50, 0, 5, "R")
j:: MouseMove(0, 50, 5, "R")
k:: MouseMove(0, -50, 5, "R")
l:: MouseMove(50, 0, 5, "R")
u::Wheelup
d::WheelDown
Enter:: ToolTip(), MouseClick("Right")
.:: ToolTip(), MouseClick("Left")
m:: global Mode := "NORMAL"
#HotIf

#HotIf Mode == "WINDOW"
h:: MouseMove(-50, 0, 5, "R")
j:: MouseMove(0, 50, 5, "R")
k:: MouseMove(0, -50, 5, "R")
l:: MouseMove(50, 0, 5, "R")
#HotIf

#HotIf WinActive("Task View ahk_class XamlExplorerHostIslandWindow")
h::Left
j::Up  ; Down focuses the
k::Up
l::Right

^h:: {
  Send("{Tab}{Left}{Space}")
  Sleep(50)
  Send("{Shift Down}{Tab}{Shift Up}")
}
^l:: {
  Send("{Tab}{Right}{Space}")
  Sleep(50)
  Send("{Shift Down}{Tab}{Shift Up}")
}
#HotIf
;#ENDREGION


;#REGION Aliases
::d-c::docker-compose
::w-i::winget install
::w-s::winget search

::;r::site:reddit.com
::;22::after:2022
::;23::after:2023
::;24::after:2024
::;sr::after:2022 site:reddit.com
::!@g::!g

::ahkv2::AutoHotkey v2
::ahkv1::AutoHotkey v1
;#ENDREGION


;#REGION Typo Auto-Correction
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
::javascirp::javascript
::ocnst::const
::dispaly::display
::fielkd::field
::2004scpae::2004scape
::preiflled::prefilled
::ocnfig::config
::searhc::search
::redidt::reddit
::puhs::push
::auothotkey::autohotkey
::auot::auto
::librayr::library
::spellhcekc::spellcheck
::hcekc::check
::barnds::brands
::svletekit::sveltekit
::svlete::svelte
::isntall::install
::functoin::function
;#ENDREGION

ToolTip("Enhancements Loaded")
SetTimer(ToolTip, 5000)
