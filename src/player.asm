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
    ld a, 16 + 8 * 1; PLAYER_Y
    ldi [hl], a
    ld a, 8 + 8 * 1; PLAYER_X
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
    ld a, [PLAYER_Y]
    ld b, a
    ld a, [PLAYER_X]
    ld c, a
    ld a, [JOYPAD]

    bit BUTTON_RIGHT, a
    jr z, .no_right
    ;right pressed
    ld e, %00011111
    ld a, c
    add a, $08
    ld c, a
    jr .direction_pressed
.no_right:
    bit BUTTON_LEFT, a
    jr z, .no_left
    ;left pressed
    ld e, %00101111
    ld a, c
    sub a, $08
    ld c, a
    jr .direction_pressed
.no_left:
    bit BUTTON_UP, a
    jr z, .no_up
    ;up pressed
    ld e, %01001111
    ld a, b
    sub a, $08
    ld b, a
    jr .direction_pressed
.no_up:
    bit BUTTON_DOWN, a
    jr z, .no_direction_pressed
    ;down pressed
    ld e, %10001111
    ld a, b
    add a, $08
    ld b, a
.direction_pressed:
    push de
    call is_solid
    pop de
    jr nz, .no_direction_pressed
    ld hl, PLAYER_MOVING
    ld [hl], e
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

    ret