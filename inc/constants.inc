BCPS                    EQU    $FF68; BCPS = Background Color Palette Specificat
BCPD                    EQU    $FF69; BCPS = Background Color Palette Data
JOYPAD_CTRL             EQU    $FF00
LCD_CTRL                EQU    $FF40
LCD_STAT                EQU    $FF41
LCD_SCROLL_Y            EQU    $FF42
LCD_SCROLL_X            EQU    $FF43
LCD_LINE_Y              EQU    $FF44
LCD_LINE_Y_CP           EQU    $FF45
OAM_DMA_TRANS           EQU    $FF46
LCD_BG_PAL              EQU    $FF47
OBJ0_PAL                EQU    $FF48
OBJ1_PAL                EQU    $FF49
WIN_Y                   EQU    $FF4A
WIN_X                   EQU    $FF4B
LCD_WIDTH               EQU    160
LCD_HEIGHT              EQU    144
VRAM_TILES_SPRITE       EQU    $8000
VRAM_TILES_MIX          EQU    $8800
VRAM_TILES_BACKGROUND   EQU    $9000
VRAM_MAP_BG             EQU    $9800
VRAM_MAP_CHR            EQU    $9C00
VRAM_MAP_BLOCK0_SIZE    EQU    $0800
OAM_RAM                 EQU    $FE00
DMA_ROUTINE             EQU    $FF80
BUTTON_A                EQU    $0
BUTTON_B                EQU    $1
BUTTON_SELECT           EQU    $2
BUTTON_START            EQU    $3
BUTTON_RIGHT            EQU    $4
BUTTON_LEFT             EQU    $5
BUTTON_UP               EQU    $6
BUTTON_DOWN             EQU    $7
OAM_BUF                 EQU    $CF00

; defined in globals:
; VBLANK_FLAG
; JOYPAD
; 
; OAM_BUF_END