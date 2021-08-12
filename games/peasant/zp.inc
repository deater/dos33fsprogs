NIBCOUNT	= $09

TEMP0   = $10
TEMP1   = $11
TEMP2   = $12
TEMP3   = $13
TEMP4   = $14
TEMP5   = $15

HGR_BITS	= $1C

GBASL		= $26
GBASH		= $27

CURSOR_X	= $62
CURSOR_Y	= $63

WHICH_LOAD=$80

WHICH_SLOT	= $DA
CURRENT_DISK	= $DC
HGR_COLOR	= $E4


P0		= $F1
P1		= $F2
P2		= $F3
P3		= $F4
P4		= $F5
P5		= $F6

INL		= $FC
INH		= $FD
OUTL		= $FE
OUTH		= $FF

LOAD_INTRO      = 0
LOAD_TITLE      = 1
LOAD_PEASANT    = 2
LOAD_ENDING     = 3


VGI_RCOLOR      = P0
VGI_RX1         = P1
VGI_RY1         = P2
VGI_RXRUN       = P3
VGI_RYRUN       = P4
VGI_RCOLOR2     = P5    ; only for dither
COUNT		= TEMP5
