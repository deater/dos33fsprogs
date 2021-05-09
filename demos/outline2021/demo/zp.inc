;; Zero Page

;; LZ4 addresses

LZ4_SRC		= $00
LZ4_DST		= $02
LZ4_END		= $04
WHICH_LOAD	= $05
COUNT		= $06
MENU_BASE	= $06
MENU_HIGHLIGHT	= $07
DELTA		= $08


; Zero page monitor routines addresses

HGR_SHAPE	= $1A

WNDLFT		= $20
WNDWDTH		= $21
WNDTOP		= $22
WNDBTM		= $23
CH		= $24
CV		= $25
GBASL		= $26
GBASH		= $27
BASL		= $28
BASH		= $29
H2		= $2C
V2		= $2D
MASK		= $2E
COLOR_MASK	= $2F
COLOR		= $30

A5H		= $45
XREG		= $46
YREG		= $47

SEEDL		= $4E
SEEDH		= $4F

TURNING		= $60	; mode7
ANGLE		= $63	; mode7
SPACEX_I	= $6A	; mode7
SPACEX_F	= $6B	; mode7

AY_REGISTERS	= $70
A_FINE_TONE	= $70
A_COARSE_TONE	= $71
B_FINE_TONE	= $72
B_COARSE_TONE	= $73
C_FINE_TONE	= $74
C_COARSE_TONE	= $75
NOISE		= $76
ENABLE		= $77
PT3_MIXER_VAL	= $77
A_VOLUME	= $78
B_VOLUME	= $79
C_VOLUME	= $7A
ENVELOPE_FINE	= $7B
ENVELOPE_COARSE	= $7C
ENVELOPE_SHAPE  = $7D

PATTERN_L       = $7E
PATTERN_H       = $7F
ORNAMENT_L      = $80
ORNAMENT_H      = $81
SAMPLE_L        = $82
SAMPLE_H        = $83

LOOP            = $84
MB_VALUE        = $85
MB_ADDR_L	= $86
MB_ADDR_H	= $87
DONE_PLAYING    = $88
DONE_SONG       = $89
PT3_TEMP	= $8A

OVER_LAND	= $8B
NUM1L		= $8C	; multiply
NUM1H		= $8D
NUM2L		= $8E
NUM2H		= $8F
RESULT		= $90	; multiply
			; 91, 92, 93
SPACEY_I	= $94
SPACEY_F	= $95
DISTANCE_I	= $96
DISTANCE_F	= $97
SCREEN_Y	= $98
FACTOR_I	= $99
FACTOR_F	= $9A
DX_I		= $9B
DX_F		= $9C
DY_I		= $9D
DY_F		= $9E
CX_I		= $9F
CX_F		= $A0
CY_I		= $A1
CY_F		= $A2
SPACEZ_I	= $A3
SPACEZ_F	= $A4
DRAW_SPLASH	= $A5
SPEED		= $A6
SPLASH_COUNT	= $A7
LOAD_WORLD	= $A8
LASTKEY		= $A9
KEY_OFFSET	= $AA
KEY_COUNT	= $AB

SHIPY		= $E4 ; mode7

HGR_SCALE	= $E7

DISP_PAGE	= $ED
DRAW_PAGE	= $EE

FRAME		= $EF

TINL		= $F0
XPOS		= $F0	; shimmer
XX		= $F0	; a2
FRAMEH		= $F0	; credits

TINH		= $F1
YPOS		= $F1	; shimmer
XHIGH		= $F1	; credits
X0		= $F1	; a2

BINL		= $F2
DIRECTION	= $F2	; shimmer
Y1		= $F2	; a2
LOGO_OFFSET	= $F2	; credits

BINH		= $F3


SCROLL_COUNT	= $F9

TEMP		= $FA
DROPL		= $FA	; drops

TEMPY		= $FB
DROPH		= $FB	; drops

INL		= $FC
BUF1L		= $FC	; drops
CTEMP		= $FC	; wires

INH		= $FD
BUF1H		= $FD	; drops

OUTL		= $FE
BUF2L		= $FE	; drops

OUTH		= $FF
BUF2H		= $FF	; drops
