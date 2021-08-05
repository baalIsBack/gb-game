INCLUDE "inc/constants.inc"



SECTION "game", ROMX
load_game_data::
	ld bc, Sprites_grass_end - Sprites_grass
	ld hl, Sprites_grass
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