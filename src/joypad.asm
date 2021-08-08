INCLUDE "inc/constants.inc"

SECTION "joypad", ROMX
read_joypad::

    ; dpad; becomes high
    ld a, $20
    ldh [JOYPAD_CTRL], a
    ld a, [JOYPAD_CTRL]; stabilize input
    ld a, [JOYPAD_CTRL]
    cpl
    and a, $0f
    swap a
    ld b, a
    
    ; buttons; becomes low
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
    or a, b
    ld [JOYPAD], a
    ret
