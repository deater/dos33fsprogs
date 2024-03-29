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
FRAME		= $E5
SECONDS		= $E6
COPY_X1		= $E7
COPY_Y1		= $E8
COPY_WIDTH	= $E9
COPY_Y2		= $EA

MASKL		= $EC
MASKH		= $ED


SPRITE_Y	= $F2
SPRITE_X	= $F3
CURRENT_ROW	= $F4
ANIMATE_COUNT	= $F5
FLAME_L		= $F6
FLAME_R		= $F7
FLAME_BG	= $F8
FLAME_DELAY	= $F9

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

