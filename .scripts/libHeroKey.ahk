#Requires AutoHotkey v2.0

;;;;;;;;;;;;;;
;;; libHeroKey
;;; Sample Use
;; key-hold functionality
;#Include "libHeroKey.ahk"
;onHeroKeyDown() {
;  ToolTip()
;  SetTrayIcon(isActive := true)
;}
;onHeroKeyHold() {
;  ToolTip("CapsLock Held")
;}
;~CapsLock:: onHeroPress(onHeroKeyDown, onHeroKeyHold)

;; repeated key-press functionality
;onHeroKeyUp(repeats) {
;  switch (repeats) {
;    case 2: ToolTip("Double-Kill!")
;    case 3: ToolTip("Triple-Kill!")
;    case 4: ToolTip("Overkill!")
;    case 5: ToolTip("Killtacular!")
;    case 6: ToolTip("Killtrocity!")
;    case 7: ToolTip("Killionaire!")
;    case 8: ToolTip("Killtastrophe!")
;    case 9: ToolTip("Killpocalypse!")
;    case 10: ToolTip("Killionaire!")
;    default: Send("{Escape}")
;  }
;  SetTimer(ToolTip, 2000)  ; clear tooltip after 2 seconds
;}
;CapsLock up:: onHeroRepeatedPresses(onRepeatedPress)

; Options
HERO_KEY := "CapsLock"
HERO_RESET_TIMEOUT_MS := 500
HERO_REPEAT_TIMEOUT_MS := 500
HERO_HOLD_MS := 1000

; Globals
HERO_KEY_DOWN := "~" . HERO_KEY
HERO_KEY_UP := HERO_KEY . " up"
HERO_PRIOR_HOTKEY := HERO_KEY_DOWN
HERO_PRESS_TICK := 0
HERO_PRIOR_PRESS_TICK := 0
HERO_REPEATED_PRESSES := 0


onHeroKeyPress(keyDownCallback, keyHoldCallback) {
  if (A_PriorHotkey == HERO_KEY_DOWN)  ; dont keep re-running this on key hold
    return

  if (!keyDownCallback())
    global HERO_PRIOR_HOTKEY := HERO_KEY_DOWN

  global HERO_PRESS_TICK := A_TickCount
  global HERO_PRIOR_HOTKEY := A_PriorHotkey

  ; run CapsLockLongHold() when detected long-hold key-down
  ; the key-up will update A_ThisHotkey, so the check is necessary
  KeyWait(HERO_KEY, "T" (HERO_HOLD_MS / 1000))
  if (
    A_ThisHotkey == HERO_KEY_DOWN &&
    A_PriorHotkey == HERO_KEY_UP &&
    A_TickCount - HERO_PRESS_TICK >= HERO_HOLD_MS
  )
    if (!keyHoldCallback()) ; return false to block key-up event
      global HERO_PRIOR_HOTKEY := HERO_KEY_DOWN
}


onHeroKeyRepeatedPresses(keyUpCallback) {
  global HERO_PRESS_TICK, HERO_REPEATED_PRESSES, HERO_PRIOR_PRESS_TICK, HERO_PRIOR_HOTKEY
  ElapsedPressTime := A_TickCount - HERO_PRESS_TICK
  isPriorHotkey := A_PriorHotkey == HERO_KEY_DOWN

  ; reset repeated presses if more than ...-ms since prior key-up
  if (!isPriorHotkey || A_TickCount - HERO_PRIOR_PRESS_TICK > HERO_RESET_TIMEOUT_MS)
    HERO_REPEATED_PRESSES := 0

  ; increment repeated presses if pressed for longer than ...-ms between presses
  if (ElapsedPressTime <= HERO_REPEAT_TIMEOUT_MS)
    HERO_REPEATED_PRESSES++

  if (isPriorHotkey && HERO_PRIOR_HOTKEY == HERO_KEY_UP)
    keyUpCallback(HERO_REPEATED_PRESSES)

  HERO_PRIOR_PRESS_TICK := A_TickCount
}
