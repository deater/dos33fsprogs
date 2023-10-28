;; Zero Page

;; ZX0 addresses

ZX0_src		= $00
ZX0_dst		= $02
offset		= $04
bitr		= $06
pntr		= $07
WHICH_LOAD	= $09
CURRENT_DISK	= $0A

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
H2	= $2C
V2	= $2D
MASK	= $2E
COLOR	= $30
			;INVFLG	= $32

; dos33 zero page = 26-2f, 35-38, 3e 3f 40-4d 
; overlap applesoft  67-6a,6f,70,af,b0,ca-cd,d8 


; DOS33: Confirmed kills $68

RWTSL		= $60
RWTSH		= $61
DOSBUFL		= $62
DOSBUFH		= $63
FILEML		= $64
FILEMH		= $65


FRAME           = $60
FRAMEL		= $60
FRAMEH		= $61
WAITING         = $62
LETTERL         = $63
LETTERH         = $64
LETTERX         = $65
LETTERY         = $66
LETTERD         = $67
LETTER          = $68
BLARGH          = $69

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

; rest of pt3_player
; rest of pt3_player
PT3_TEMP        = $80
ORNAMENT_L      = $81
ORNAMENT_H      = $82
SAMPLE_L        = $83
SAMPLE_H        = $84
LOOP            = $85
MB_VALUE        = $86
MB_ADDR_L       = $87
MB_ADDR_H       = $88
DONE_PLAYING    = $89
DONE_SONG       = $8A
APPLEII_MODEL   = $8B
SOUND_STATUS    = $8C
        SOUND_DISABLED  = $80
        SOUND_IN_LC     = $01 ; $01 sound effects in language card
        SOUND_MOCKINGBOARD = $02 ; mockingboard detected
DISP_PAGE	= $8D
DRAW_PAGE	= $8E

TOTAL_RAM       = $8F

;TIMER_COUNT	= $86
;WHICH_SLOT      = $88



NUM1L	= $90
NUM1H	= $91
NUM2L	= $92
NUM2H	= $93
RESULT	= $94	; 95,96,97
SCALE_I	= $98
SCALE_F	= $99
ANGLE	= $9A

; More zero-page addresses
; we try not to conflict with anything DOS, MONITOR or BASIC related

			;COLOR1		=	$E0
			;COLOR2		=	$E1
			;MATCH		=	$E2

HGR_COLOR       = $E4
			;SHIPY		=	$E4
			;YADD		=	$E5
			;LOOP		=	$E6
			;MEMPTRL	=	$E7
			;MEMPTRH	=	$E8
			;NAMEL		=	$E9
			;NAMEH		=	$EA
			;NAMEX		=	$EB
			;CHAR		=	$EC

LAST_TYPE = $E6
COLOR2	= $E7
X1	= $E8
X2	= $E9
Y1	= $EA
Y2	= $EB
SCENE_COUNT = $EC

STATE           = $ED
OFFSET         = $EF


; COMMON DON'T USE
IRQ_COUNTDOWN	= $F0
COUNT           = $F1


SPRITETEMP	=	$F2
XPOS		=	$F3
YPOS		=	$F4
XSAVE		=	$F6
SCROLL_IN	=	$F7
SCROLL_OUT	=	$F8
STRING_COUNT	=	$F9
TEMP		=	$FA
MEMCOUNT	=	$FA
TEMPY		=	$FB
LEAD0		=	$FB
INL		=	$FC
INH		=	$FD
OUTL		=	$FE
OUTH		=	$FF

; tunnel


XX		= $F2
MINUSXX         = $F3
YY		= $F4
MINUSYY         = $F5
D               = $F6
R               = $F7
CX              = $F8
CY              = $F9
RR              = $FA

; Credits
BACKUP_OUTL	= $F2
BACKUP_OUTH	= $F3

; Nuts/ operner

SPRITE_Y	= $F2
SPRITE_X	= $F3
CURRENT_ROW	= $F4









; read any file slot 6 version
; based on FASTLD6 and RTS copyright (c) Peter Ferrie 2011-2013,2018

; modified to assembled with ca64 -- vmw
; added code to patch it to run from current disk slot -- vmw


	adrlo	=	$26	; constant from boot prom
	adrhi	=	$27	; constant from boot prom
	tmpsec	=	$3c	; constant from boot prom
	reqsec	=	$3d	; constant from boot prom
	sizelo	=	$44
	sizehi	=	$45
	secsize	=	$46

	ldsizel	=	$f0
	ldsizeh	=	$f1
	namlo	=	$fb
	namhi	=	$fc
	step	=	$fd	; state for stepper motor
	tmptrk	=	$fe	; temporary copy of current track
	phase	=	$ff	; current phase for /seek

