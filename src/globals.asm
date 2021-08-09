INCLUDE "inc/constants.inc"

SECTION "globals", WRAM0
VBLANK_FLAG::
	db
JOYPAD::
	db
MAP_POINTER_TILES::
	db
	db
MAP_POINTER_COLLISION::
	db
	db

SECTION "oam_buf", WRAM0[OAM_BUF]
	DS $100
OAM_BUF_END::