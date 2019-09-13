;; Zero page monitor routines addresses

WNDLFT	= $20
WNDWDTH	= $21
WNDTOP	= $22
WNDBTM	= $23
CH	= $24
CV	= $25
GBASL	= $26
GBASH	= $27
BASL	= $28
BASH	= $29
BAS2L	= $2A
BAS2H	= $2B
H2	= $2C
V2	= $2D
MASK	= $2E
LASTIN	= $3F
COLOR	= $30
MODE	= $31
INVFLG	= $32
PROMPT	= $33
YSAV	= $34
YSAV1	= $35
CSWL	= $36		; address of COUT1 routine
CSWH	= $37
KSWL	= $38		; key in routine
KSWH	= $39

SEEDL	=	$4E
SEEDH	=	$4F


; dos33 zero page = 26-2f, 35-38, 3e 3f 40-4d 
; overlap applesoft  67-6a,6f,70,af,b0,ca-cd,d8 


; DOS33: Confirmed kills $68

;RWTSL		= $60
;RWTSH		= $61
;DOSBUFL		= $62
;DOSBUFH		= $63
;FILEML		= $64
;FILEMH		= $65

AY_REGISTERS	= $50
	A_FINE_TONE	= $50
	A_COARSE_TONE	= $51
	B_FINE_TONE	= $52
	B_COARSE_TONE	= $53
	C_FINE_TONE	= $54
	C_COARSE_TONE	= $55
	NOISE		= $56
	ENABLE		= $57
	PT3_MIXER_VAL	= $57
	A_VOLUME	= $58
	B_VOLUME	= $59
	C_VOLUME	= $5A
	ENVELOPE_FINE	= $5B
	ENVELOPE_COARSE	= $5C
	ENVELOPE_SHAPE  = $5D
CYCLE_WASTE	= $5E

PATTERN_L	= $00
PATTERN_H	= $01
ORNAMENT_L	= $02
ORNAMENT_H	= $03
SAMPLE_L	= $04
SAMPLE_H	= $05

MB_VALUE	= $62
PT3_TEMP	= $63
LOOP		= $64
MB_ADDRL	= $65
MB_ADDRH	= $66
DONE_PLAYING	= $67
DONE_SONG	= $68
FIRE_X		= $70
DISP_PAGE	= $71
DRAW_PAGE	= $72
XPOS		= $73
YPOS		= $74
namlo		= $76
namhi		= $77
step		= $78     ; state for stepper motor
tmptrk		= $79     ; temporary copy of current track
phase		= $7a     ; current phase for /seek
TEMP		= $7A
TEMPY		= $7B
INL		= $7C
INH		= $7D
OUTL		= $7E
OUTH		= $7F


; 80+ = 120 bytes of NOTE data

