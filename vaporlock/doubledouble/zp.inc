;=========================
; zero page
;=========================

; ZX02 addresses

ZP=$00

offset          = ZP+0
ZX0_src         = ZP+2
ZX0_dst         = ZP+4
bitr            = ZP+6
pntr            = ZP+7

CH	= $24
GBASL	= $26
GBASH	= $27
BASL	= $28
BASH	= $29
V2	= $2D
COLOR	= $30

; ym player
CURRENT_FRAME_L         = $70
CURRENT_FRAME_H         = $71
BASE_FRAME_L            = $72
BASE_FRAME_H            = $73
CURRENT_CHUNK           = $74
TIME_MINUTES            = $75
TIME_SECONDS            = $76
CURSOR_X                = $77

DRAW_PAGE	= $7A

CHUNK_NEXT_LOAD         = $7D
CHUNK_NEXT_PLAY         = $7E
LOAD_NEXT_CHUNK         = $7F
TIMER_COUNT             = $81

APPLEII_MODEL	= $8B

SOUND_STATUS    =       $DE
        SOUND_DISABLED  = $80
        SOUND_IN_LC     = $01 ; $01 sound effects in language card
        SOUND_MOCKINGBOARD = $02 ; mockingboard detected




HGRPAGE = $E6



TEMPY		= $F0
XX		= $F1

; rest of pt3_player
LOOP            = $F4
MB_VALUE        = $F5
MB_ADDR_L       = $F6
MB_ADDR_H       = $F7
DONE_PLAYING    = $F8
DONE_SONG       = $F9


YPOS		= $FA
TCOLOR		= $FB

INL		= $FC
INH		= $FD
OUTL		= $FE
OUTH		= $FF
