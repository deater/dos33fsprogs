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

; pt3 player

ORNAMENT_L      = $60
ORNAMENT_H      = $61
SAMPLE_L        = $62
SAMPLE_H        = $63

LOOP            = $64
MB_ADDR_L       = $65
MB_ADDR_H       = $66
MB_VALUE        = $67
DONE_PLAYING    = $68
DONE_SONG       = $69
PT3_TEMP        = $6A
APPLEII_MODEL   = $6B


AY_REGISTERS    = $70
A_FINE_TONE     = $70
A_COARSE_TONE   = $71
B_FINE_TONE     = $72
B_COARSE_TONE   = $73
C_FINE_TONE     = $74
C_COARSE_TONE   = $75
NOISE           = $76
ENABLE          = $77
PT3_MIXER_VAL   = $77
A_VOLUME        = $78
B_VOLUME        = $79
C_VOLUME        = $7A
ENVELOPE_FINE   = $7B
ENVELOPE_COARSE = $7C
ENVELOPE_SHAPE  = $7D

PATTERN_L       = $7E
PATTERN_H       = $7F


DRAW_PAGE	= $8A

SOUND_STATUS    =       $DE
        SOUND_DISABLED  = $80
        SOUND_IN_LC     = $01 ; $01 sound effects in language card
        SOUND_MOCKINGBOARD = $02 ; mockingboard detected




HGRPAGE = $E6



TEMPY		= $F0
XX		= $F1
FRAME		= $F2


YPOS		= $FA
TCOLOR		= $FB

INL		= $FC
INH		= $FD
OUTL		= $FE
OUTH		= $FF
