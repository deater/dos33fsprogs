; zero page

; pre-defined applesoft vars

HGR_BITS	= $1C

CH      = $24
CV      = $25
GBASL   = $26
GBASH   = $27
BASL    = $28
BASH    = $29

; our init routine zeros $60-$90 at start


AY_REGS		= $70
;	through = $7D

FRAME		= $80
FRAMEH		= $81
WHICH_TRACK	= $82
SONG_COUNTDOWN	= $83


OUR_ROT		= $A5

HGR_X           = $E0
HGR_XH          = $E1
HGR_Y           = $E2
HGR_COLOR       = $E4
HGR_PAGE        = $E6
HGR_SCALE	= $E7

OUTL		= $F4
OUTH		= $F5
LINE		= $F6

WHICH           =       $FB
SCALE           =       $FC
ROTATE          =       $FD
XPOS            =       $FE
YPOS            =       $FF


