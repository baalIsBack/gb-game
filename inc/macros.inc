MACRO reset
call wait_vblank
call lcd_off
call clear_bg_map
call lcd_on
;ld SP, $FFFF
ld HL, LCD_SCROLL_Y
ld [HL], $00
ld HL, LCD_SCROLL_X
ld [HL], $00
ENDM

MACRO dcolor; $rrggbb -> gbc representation
_r = ((\1) & $ff0000) >> 16 >> 3
_g = ((\1) & $00ff00) >> 8  >> 3
_b = ((\1) & $0000ff) >> 0  >> 3
dw (_r << 0) | (_g << 5) | (_b << 10)
ENDM
