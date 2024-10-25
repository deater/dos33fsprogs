;==================
;==================
; Zero Page Usage
;==================
;==================

; ZX0 decompression addresses

ZX0_src		= $00
ZX0_dst		= $02
offset		= $04
bitr		= $06
pntr		= $07
WHICH_LOAD	= $09
CURRENT_DISK	= $0A

; Zero page monitor routines addresses
; We don't use the monitor but we use some of these anyway

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

WHICH_TRACK	= $54

;==========================
; $60-$6F unused currently
;==========================


;==========================
; $70-$7F for PT3 Player
;==========================

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

;============================
; $80-$8D rest of pt3_player
;============================

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

;=============================
; not sure why these are here
;=============================

DISP_PAGE	= $8D
DRAW_PAGE	= $8E
TOTAL_RAM       = $8F

;=============================
; $90-$CF currently free
;=============================

Table1  = $A0   ; 40 bytes ($28) A0-C7
Table2  = $C8   ; 40 bytes ($28) C8-EF

;=============================
; $D0-$D9 = hgr move
;=============================
HGR_X1	= $D0
HGR_X2	= $D1
HGR_Y1	= $D2
HGR_Y2	= $D3
HGR_DEST= $D4
BOARD_COUNT	= $D5


WHICH_SLOT = $DA		; from boot sector


;==============================================
; $E0-$EF use for common things, don't re-use
;==============================================
IRQ_COUNTDOWN	= $E0
SECOND_COUNTDOWN= $E1
COUNT           = $E2
XSAVE		= $E3
TEMPY		= $E4
XPOS		= $E5	; gr_plot
YPOS		= $E6	; gr_plot
COLOR_MASK	= $E7	; gr_plot
FRAME           = $E8
FRAMEL		= $E8
FRAMEH		= $E9
BTC_L		= $EA	; audio
BTC_H		= $EB	; audio
MASKL		= $EC	; gr_putsprite_mask
MASKH		= $ED

;==============================================
; $F0-$FB can re-use in each file
;==============================================

; D'NI

SPRITEY		= $EE
SPRITEX		= $EF
SPRITE_XSIZE	= $F0
SIN_COUNT	= $F1
NUMBER_HIGH	= $F2
NUMBER_LOW	= $F3
DRAW_NUMBER	= $FA

;OUT1		= $F0
;OUT1H		= $F1
;OUT2		= $F2
;OUT2H		= $F3
;COMPT1		= $F4
;COMPT2		= $F5
;PARAM1		= $F6
;PARAM2		= $F7
;PARAM3		= $F8
;PARAM4		= $F9
;GRLINE		= $FA
;GRLINEH		= $FB



; Credits
BACKUP_OUTL	= $F2
BACKUP_OUTH	= $F3



; PLASMACUBE
;OUT1		= $F0
;OUT1H		= $F1
;OUT2		= $F2
;OUT2H		= $F3
COMPT1		= $F4
COMPT2		= $F5
PARAM1		= $F6
PARAM2		= $F7
PARAM3		= $F8
PARAM4		= $F9
;GRLINE		= $FA
;GRLINEH	= $FB

; PLASMA

; CUBE
SAVEX		= $F3
SAVEY		= $F4
SUM		= $F5

; CIRCLES/DRAW_BOXES
COLOR2		= $F3
X1		= $F4
X2		= $F5
Y1		= $F6
Y2		= $F7
SCENE_COUNT	= $F8
LAST_TYPE	= $F9

; lens
LENS_X		= $F0
LENS_Y		= $F1
XADD		= $F2
YADD		= $F3

; rotozoom
NUM1L		= $F0
NUM1H		= $F1
NUM2L		= $F2
NUM2H		= $F3
RESULT		= $F4	; F5,F6,F7
SCALE_I		= $F8
SCALE_F		= $F9
ANGLE		= $FA

; credits
SCROLL_X	= $F0

; polar
SCROLL_START	= $F0
YDEST		= $F1

; sierzoom
;XX     =       $F0
XX_TH   =       $F1
XX_TL   =       $F2
;YY     =       $F3
YY_TH   =       $F4
YY_TL   =       $F5
T_L     =       $F6
T_H     =       $F7
SAVED   =       $F8

BAR_X1 =	$F0
BAR_X2	=	$F1

; spheres
BASE_SPRITEL	= $F0
BASE_SPRITEH	= $F1
CURRENT_SPRITEL	= $F2
CURRENT_SPRITEH	= $F3
XMISSION_COUNT	= $F4
REF1L		= $F5
REF1H		= $F6
REF2L		= $F7
REF2H		= $F8
REFCOUNT	= $F9

; BIOS
STRING_COUNT	= $F0
LEAD0		= $F1
SCROLL_OUT	= $F2
SCROLL_IN	= $F3
MEMCOUNT	= $F4
FAKE_KEY_COUNT	= $F5

; OPENER
TICKER		= $F1
P2_OFFSET	= $F2

; dots
MAX_DOTS	= $F1
Y_OFFSET	= $F2

;==============================================
; $FC-$FF we use for in/out pointers
;==============================================

INL		=	$FC
INH		=	$FD
OUTL		=	$FE
OUTH		=	$FF


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

