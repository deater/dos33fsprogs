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

RWTSL		= $60
RWTSH		= $61
DOSBUFL		= $62
DOSBUFH		= $63
FILEML		= $64
FILEMH		= $65

AY_REGISTERS	= $70
A_FINE_TONE	= $70
A_COARSE_TONE	= $71
B_FINE_TONE	= $72
B_COARSE_TONE	= $73
C_FINE_TONE	= $74
C_COARSE_TONE	= $75
NOISE		= $76
ENABLE		= $77
A_VOLUME	= $78
B_VOLUME	= $79
C_VOLUME	= $7A
ENVELOPE_FINE	= $7B
ENVELOPE_COARSE	= $7C
ENVELOPE_SHAPE  = $7D
COPY_OFFSET	= $7E
DECODER_STATE	= $7F

PATTERN_L	= $80
PATTERN_H	= $81
ORNAMENT_L	= $82
ORNAMENT_H	= $83
SAMPLE_L	= $84
SAMPLE_H	= $85

DECODE_ERROR	= $90
A_COLOR		= $91
B_COLOR		= $92
C_COLOR		= $93
COPY_TIME	= $94
DECOMPRESS_TIME	= $95
TIME_TAKEN	= $96
SCREEN_Y	= $97
WHICH_FILE	= $98
COLOR_MASK	= $99
RASTERBARS_ON	= $9A
RANDOM_POINTER	= $9B
LOOP		= $9C
MB_VALUE	= $9D
;MB_CHUNK	= $9E
MB_ADDRL	= $9F
MB_ADDRH	= $A0
DONE_PLAYING	= $A1
MB_CHUNK_OFFSET = $A2
DONE_SONG	= $A3
FIRE_FB_L	= $A4
FIRE_FB_H	= $A5
FIRE_FB2_L	= $A6
FIRE_FB2_H	= $A7
FIRE_FB_LINE	= $A8
FIRE_Q		= $A9
FIRE_Y		= $AA
FIRE_X		= $AB

; More zero-page addresses
; we try not to conflict with anything DOS, MONITOR or BASIC related

			;COLOR1		= $E0
COLOR2	= $E1
			;MATCH		= $E2
XX	= $E3
			;YY		= $E4
			;SHIPY		= $E4
			;YADD		= $E5
			;LOOP		= $E6
			;MEMPTRL	= $E7
			;MEMPTRH	= $E8
	;NAMEL		=	$E9
	;NAMEH		=	$EA
				;NAMEX		=	$EB
				;CHAR		=	$EC
DISP_PAGE	= $ED
DRAW_PAGE	= $EE

				;FIRST		=	$F0
LASTKEY		= $F1
				;PADDLE_STATUS	=	$F2
XPOS		= $F3
YPOS		= $F4


       namlo   =       $f6
       namhi   =       $f7
       step    =       $f8     ; state for stepper motor
       tmptrk  =       $f9     ; temporary copy of current track
       phase   =       $fa     ; current phase for /seek



TEMP		= $FA
				;RUN		=	$FA
				;TEMP2		=	$FB
TEMPY		= $FB
INL		= $FC
INH		= $FD
OUTL		= $FE
OUTH		= $FF

