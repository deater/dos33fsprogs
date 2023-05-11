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

DRAW_PAGE	= $7A

APPLEII_MODEL	= $8B

SOUND_STATUS    =       $DE
        SOUND_DISABLED  = $80
        SOUND_IN_LC     = $01 ; $01 sound effects in language card
        SOUND_MOCKINGBOARD = $02 ; mockingboard detected




HGRPAGE = $E6



TEMPY		= $F0
XX		= $F1



MB_VALUE	= $F7
MB_ADDR_L	= $F8
MB_ADDR_H	= $F9
YPOS		= $FA
TCOLOR		= $FB

INL		= $FC
INH		= $FD
OUTL		= $FE
OUTH		= $FF
