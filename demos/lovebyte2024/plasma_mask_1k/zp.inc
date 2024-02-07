; zero page

; zx02

offset          = $00
ZX0_src         = $02
ZX0_dst         = $04
bitr            = $06
pntr            = $07

; pre-defined applesoft vars

CH      = $24
CV      = $25
GBASL   = $26
GBASH   = $27
BASL    = $28
BASH    = $29

COMPT1	= $30
COMPT2	= $31

PARAM1	= $60
PARAM2	= $61
PARAM3	= $62
PARAM4	= $63

AY_REGS		= $70
; through	= $7F

SONG_L		= $80
SONG_H		= $81
SONG_OFFSET	= $82
SONG_COUNTDOWN	= $83
OCTAVE		= $84
REGISTER	= $85
A_COUNTDOWN	= $86
B_COUNTDOWN	= $87

Table1	= $A0	; 40 bytes ($28) A0-C7
Table2	= $C8	; 40 bytes ($28) C8-EF

;OUR_ROT		= $A5
;HGR_X           = $E0
;HGR_XH          = $E1
;HGR_Y           = $E2
;HGR_COLOR       = $E4
;HGR_PAGE        = $E6
;HGR_SCALE	= $E7

XSAVE		= $FA
COUNT		= $FB
FRAME		= $FC
WHICH_TRACK	= $FD
INL		= $FE
INH		= $FF
