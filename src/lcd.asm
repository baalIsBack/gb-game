SECTION "lcd", ROMX

INCLUDE "inc/constants.inc"

lcd_off::
    ld HL, LCD_CTRL
    res 7, [HL]
    ret

lcd_on::
    ld HL, LCD_CTRL
    set 7, [HL]
    ret

wait_vblank::
    ld A, [LCD_LINE_Y]
    cp 144
    jr nz, wait_vblank
    ret

clear_bg_map::
    ld HL, $9C00

.clear_loop:
    ld [HL], B
    inc HL
    ld A, H
    cp $9F
    jr nz, .clear_loop
    ld A, L
    cp $FF
    jr nz, .clear_loop
    ret

load_dma_routine::
    ld bc, .dma_routine_end - .dma_routine
    ld hl, .dma_routine
    ld de, DMA_ROUTINE
    call ldir
    ret

.dma_routine:
    ; start the transfer, as shown above
    ld a, OAM_BUF/256
    ld [OAM_DMA_TRANS], a

    ; wait 160 cycles/microseconds, the time it takes for the
    ; transfer to finish; this works because 'dec' is 1 cycle
    ; and 'jr' is 3, for 4 cycles done 40 times
    ld      a, 40
.loop_dma_routine:
    dec     a
    jr      nz, .loop_dma_routine

    ; return
    ret
.dma_routine_end: