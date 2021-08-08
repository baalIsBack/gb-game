INCLUDE "inc/constants.inc"



SECTION "game", ROMX
load_game_data::
	ld bc, Sprites_grass_end - Sprites_grass
	ld hl, Sprites_grass
	ld de, VRAM_TILES_BACKGROUND + $10
	call ldir
	ld hl, VRAM_MAP_BG-1
	ld a, $01
	ld [hl], a
	ld bc, $a000 - VRAM_MAP_BG
	ld de, VRAM_MAP_BG
	call ldir

	call load_player_data

	ret
update_game::
    call update_player

	ret
draw_game::
	call draw_player



	ret