INCLUDE "inc/constants.inc"

SECTION "joypad", ROMX
read_joypad::
    ; dpad
    ld a, $20
    ldh [JOYPAD_CTRL], a
    ld a, [JOYPAD_CTRL]; stabilize input
    ld a, [JOYPAD_CTRL]
    cpl
    and a, $0f
    ld b, a
    ; buttons
    ld a, $10
    ldh [JOYPAD_CTRL], a
    ld a, [JOYPAD_CTRL]; stabilize
    ld a, [JOYPAD_CTRL]; stabilize
    ld a, [JOYPAD_CTRL]; stabilize
    ld a, [JOYPAD_CTRL]; stabilize
    ld a, [JOYPAD_CTRL]; stabilize
    ld a, [JOYPAD_CTRL]
    cpl
    and a, $0f
    swap a
    or a, b
    ld [JOYPAD], a
    ret
