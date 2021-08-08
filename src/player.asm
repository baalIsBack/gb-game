INCLUDE "inc/constants.inc"


SECTION "player_vars", WRAM0
PLAYER_Y: DS 1; top:  $10
PLAYER_X: DS 1; left: $08
PLAYER_MOVING: DS 1; down, up, left, right, moving, distanceRemaining, distanceRemaining, distanceRemaining
SECTION "player", ROMX
load_player_data::
    ld bc, Sprites_player_end - Sprites_player
    ld hl, Sprites_player
    ld de, VRAM_TILES_SPRITE
    call ldir


    ld hl, PLAYER_Y
    ld a, 8 + 8 * 1; PLAYER_Y
    ldi [hl], a
    ld a, 16 + 8 * 1; PLAYER_X
    ldi [hl], a
    ld a, %00000000
    ldi [hl], a

    ; - - Nintendo - background
    ;default: %11100100
    ; good: %01101100
    ld a, %11100100

    ld [LCD_BG_PAL], a


    ret

update_player::
    ld a, [PLAYER_MOVING]
    bit 3, a
    jr z, .check_movement
    ld e, a
    ld hl, PLAYER_Y
    ldi a, [hl]
    ld b, a
    ld a, [hl]
    ld c, a
    dec hl
    ld a, e
    bit BUTTON_RIGHT, a
    jr z, .no_moving_right
    ; right moving
    inc c
    jr .moving
.no_moving_right
    bit BUTTON_LEFT, a
    jr z, .no_moving_left
    ; left moving
    dec c
    jr .moving
.no_moving_left
    bit BUTTON_UP, a
    jr z, .no_moving_up
    ; up moving
    dec b
    jr .moving
.no_moving_up
    bit BUTTON_DOWN, a
    jr z, .moved
    ; down moving
    inc b
.moving:
    dec a
    ld [hl], b
    inc hl
    ld [hl], c
    inc hl
    ld [hl], a
.moved:

    ret
.check_movement:
    ld a, [JOYPAD]

    bit BUTTON_RIGHT, a
    jr z, .no_right
    ;right pressed
    ld b, %00011111
    jr .direction_pressed
.no_right:
    bit BUTTON_LEFT, a
    jr z, .no_left
    ;left pressed
    ld b, %00101111
    jr .direction_pressed
.no_left:
    bit BUTTON_UP, a
    jr z, .no_up
    ;up pressed
    ld b, %01001111
    jr .direction_pressed
.no_up:
    bit BUTTON_DOWN, a
    jr z, .no_direction_pressed
    ;down pressed
    ld b, %10001111
.direction_pressed:
    ld hl, PLAYER_MOVING
    ld [hl], b

.no_direction_pressed:
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