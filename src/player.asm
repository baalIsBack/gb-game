INCLUDE "inc/constants.inc"
INCLUDE "assets/sprites_player.inc"


SECTION "player_vars", WRAM0
PLAYER_Y: DS 1; top:  $10
PLAYER_X: DS 1; left: $08

SECTION "player", ROMX
load_player_data::
    ld bc, Sprites_player_end - Sprites_player
    ld hl, Sprites_player
    ld de, VRAM_TILES_SPRITE
    call ldir


    ld hl, PLAYER_Y
    ld a, $58; PLAYER_Y
    ldi [hl], a
    ld a, $4f; PLAYER_X
    ldi [hl], a

    ; - - Nintendo - background
    ;default: %11100100
    ; good: %01101100
    ld a, %11100100

    ld [LCD_BG_PAL], a


    ret

update_player::
    ld hl, PLAYER_Y
    ld b, [hl];y-pos
    inc hl
    ld c, [hl];x-pos
    dec hl

    ld a, [JOYPAD]

    bit BUTTON_RIGHT, a
    jr z, .no_right
    ;right pressed
    inc c
.no_right:
    bit BUTTON_LEFT, a
    jr z, .no_left
    ;left pressed
    dec c
.no_left:
    bit BUTTON_UP, a
    jr z, .no_up
    ;up pressed
    dec b
.no_up:
    bit BUTTON_DOWN, a
    jr z, .no_down
    ;down pressed
    inc b
.no_down:
    ld [hl], b
    inc hl
    ld [hl], c

    ret

draw_player::
    ld hl, OAM_BUF
    ld a, [PLAYER_Y]
    ldi [hl], a
    ld a, [PLAYER_X]
    ldi [hl], a
    ld a, $00;sprite id = 0
    ldi [hl], a
    ld a, %00000001
    ldi [hl], a

    ;call DMA_ROUTINE

    ;ld hl, VRAM_MAP_BG
    ;ld a, $80
    ;ld [hl], a

    ret