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

PEASANT_X	= $60
PEASANT_Y	= $61
PEASANT_DIR	= $62
	PEASANT_DIR_UP		= 0
	PEASANT_DIR_RIGHT	= 1
	PEASANT_DIR_LEFT	= 2
	PEASANT_DIR_DOWN	= 3
CURSOR_X	= $63
CURSOR_Y	= $64
FRAME		= $65
ALTFIRE		= $66
ALTL		= $67
ALTH		= $68
SAVED_X		= $69

; pt3 player registers
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

WHICH_LOAD	= $80

; rest of pt3_player
PT3_TEMP        = $81
ORNAMENT_L      = $82
ORNAMENT_H      = $83
SAMPLE_L        = $84
SAMPLE_H        = $85
LOOP            = $86
MB_VALUE        = $87
MB_ADDR_L       = $88
MB_ADDR_H       = $89
DONE_PLAYING    = $8A
DONE_SONG       = $8B
APPLEII_MODEL	= $8C




; D0-D? used by HGR?

INPUT_X		= $C0
BOX_X1L		= $C1
BOX_X1H		= $C2
BOX_Y1		= $C3
BOX_X2L		= $C4
BOX_X2H		= $C5
BOX_Y2		= $C6

WHICH_SLOT	= $DA
CURRENT_DISK	= $DC
HGR_COLOR	= $E4
HGR_PAGE	= $E6



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

; constants

LOAD_VID_LOGO   = 0
LOAD_TITLE      = 1
LOAD_INTRO      = 2
LOAD_COPY_CHECK = 3
LOAD_PEASANT    = 4

VGI_RCOLOR      = P0
VGI_RX1         = P1
VGI_RY1         = P2
VGI_RXRUN       = P3
VGI_RYRUN       = P4
VGI_RCOLOR2     = P5    ; only for dither
COUNT		= TEMP5

