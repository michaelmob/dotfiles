#Requires AutoHotkey v2.0

HERO_KEY := "CapsLock"
HERO_RESET_TIMEOUT_MS := 400
HERO_REPEAT_TIMEOUT_MS := 200
HERO_HOLD_MS := 1000

HERO_PRESS_TICK := 0
HERO_PRIOR_PRESS_TICK := 0
HERO_REPEATED_PRESSES := 0


onHeroPress(keyActiveCallback, keyHoldCallback) {
  if (A_PriorHotkey == "~" . HERO_KEY)  ; dont keep re-running this on key hold
    return

  keyActiveCallback()

  global HERO_PRESS_TICK := A_TickCount
  global MouseMode := false

  ; run CapsLockLongHold() when detected long-hold key-down
  ; the key-up will update A_ThisHotkey, so the check is necessary
  KeyWait(HERO_KEY, "T" (HERO_HOLD_MS / 1000))
  if (A_ThisHotkey == "~" . HERO_KEY && A_TickCount - HERO_PRESS_TICK >= HERO_HOLD_MS)
    keyHoldCallback()
}


onHeroRepeatedPresses(repeatedPressCallback) {
  global HERO_PRIOR_PRESS_TICK, HERO_PRESS_TICK, HERO_REPEATED_PRESSES
  ElapsedPressTime := A_TickCount - HERO_PRESS_TICK
  isPriorHotkey := A_PriorHotkey == "~" . HERO_KEY

  ; reset repeated presses if more than ...-ms since prior key-up
  if (!isPriorHotkey || A_TickCount - HERO_PRIOR_PRESS_TICK > HERO_RESET_TIMEOUT_MS)
    HERO_REPEATED_PRESSES := 0

  ; increment repeated presses if pressed for longer than ...-ms between presses
  if (ElapsedPressTime <= HERO_REPEAT_TIMEOUT_MS)
    HERO_REPEATED_PRESSES++

  if (isPriorHotkey)
    repeatedPressCallback(HERO_REPEATED_PRESSES)

  HERO_PRIOR_PRESS_TICK := A_TickCount
}


; ; key-hold functionality (~ means to not block the key from being sent)
; #Include "libCapsHero.ahk"
; onActivePress() {
;   ToolTip()
;   SetTrayIcon(isActive := true)
; }
; onKeyHold() {
;   ToolTip("CapsLock Held")
; }
; ~CapsLock:: onHeroPress(onActivePress, onKeyHold)

; ; repeated key-press functionality
; onRepeatedPress(repeats) {
;   switch (repeats) {
;     case 2: ToolTip("Double-Kill!")
;     case 3: ToolTip("Triple-Kill!")
;     case 4: ToolTip("Overkill!")
;     case 5: ToolTip("Killtacular!")
;     case 6: ToolTip("Killtrocity!")
;     case 7: ToolTip("Killionaire!")
;     case 8: ToolTip("Killtastrophe!")
;     case 9: ToolTip("Killpocalypse!")
;     case 10: ToolTip("Killionaire!")
;     default: Send("{Escape}")
;   }
;   SetTimer(ToolTip, 2000)  ; clear tooltip after 2 seconds
; }
; CapsLock up:: onHeroRepeatedPresses(onRepeatedPress)
