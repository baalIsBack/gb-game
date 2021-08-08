SECTION "int $00", ROM0[$0000]
	reti
SECTION "int $08", ROM0[$0008]
	reti
SECTION "int $10", ROM0[$0010]
	reti
SECTION "int $18", ROM0[$0018]
	reti
SECTION "int $20", ROM0[$0020]
	reti
SECTION "int $28", ROM0[$0028]
	reti
SECTION "int $30", ROM0[$0030]
	reti
SECTION "int $38", ROM0[$0038]; error handler
	reti
SECTION "int $40", ROM0[$0040]; Vblank interrupt
    push hl
    ld hl, VBLANK_FLAG
    ld [hl], 1
    pop hl
    reti
SECTION "int $48", ROM0[$0048]; LCD STAT
	reti
SECTION "int $50", ROM0[$0050]; Timer overflow interrupt
	reti
SECTION "int $58", ROM0[$0058]; Serial transfer completion interrupt
	reti
SECTION "int $60", ROM0[$0060]; P10-P13 signal low edge interrupt
	reti