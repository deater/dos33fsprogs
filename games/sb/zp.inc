;; Zero Page

;; ZX02 addresses

ZP=$00

offset          = ZP+0
ZX0_src         = ZP+2
ZX0_dst         = ZP+4
bitr            = ZP+6
pntr            = ZP+7

WHICH_LOAD	= $09

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


; Electric Duet ZP usage
FREQ1          =       $06
FREQ2          =       $07
DURATION       =       $08
INSTRUMENT1    =       $09
INSTRUMENT2    =       $1D
MADDRL         =       $1E
MADDRH         =       $1F
LOC4E          =       $4E
COUNT256       =       $4F
WHICH_PAGE     =       $50



; dos33 zero page = 26-2f, 35-38, 3e 3f 40-4d 
; overlap applesoft  67-6a,6f,70,af,b0,ca-cd,d8 


FRAME           = $60
FRAMEH		= $61
SCROLL		= $62
XSAVE		= $63
SCROLL_OFFSET	= $64
BTC_L		= $65
BTC_H		= $66
SOUND_STATUS	= $67
	SOUND_DISABLED  = $80
	SOUND_IN_LC     = $01 ; $01 sound effects in language card
	SOUND_MOCKINGBOARD = $02 ; mockingboard detected
MENU_ITEM	= $68
OLD_MENU_ITEM	= $69
NOT_FIRST_TIME	= $6A
STRONGBAD_X	= $6B
PLAYER_X	= $6C
STRONGBAD_DIR	= $6D
SHIELD_POSITION = $6E
	SHIELD_DOWN = 0
	SHIELD_UP_LEFT = 1
	SHIELD_UP_CENTER = 2
	SHIELD_UP_RIGHT = 3
SHIELD_COUNT	= $6F
BULLET_X	= $70
BULLET_Y	= $71

.if 0
REGISTER_DUMP	= $70
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


REGISTER_DUMP2	= $80
A_FINE_TONE2	= $80
A_COARSE_TONE2	= $81
B_FINE_TONE2	= $82
B_COARSE_TONE2	= $83
C_FINE_TONE2	= $84
C_COARSE_TONE2	= $85
NOISE2		= $86
ENABLE2		= $87
A_VOLUME2	= $88
B_VOLUME2	= $89
C_VOLUME2	= $8A
ENVELOPE_FINE2	= $8B
ENVELOPE_COARS2	= $8C
ENVELOPE_SHAPE2 = $8D
LYRICSL		= $8E
LYRICSH		= $8F
.endif

FRAME_COUNT	= $90
MB_VALUE	= $91
MB_ADDRL	= $91
MB_ADDRH	= $92
DONE_PLAYING	= $93
MB_CHUNK_OFFSET = $94
MB_FRAME	= $94
MB_PATTERN	= $95
CHUNKSIZE	= $95
LZ4_DONE	= $96
DECODE_ERROR	= $97
COPY_TIME	= $98
DECOMPRESS_TIME	= $99
TIME_TAKEN	= $9A
LYRICS_ACTIVE	= $9B
;FORTYCOL	= $9C
CURSOR		= $9D

CURRENT_DISK	= $DC

; More zero-page addresses
; we try not to conflict with anything DOS, MONITOR or BASIC related


D1_SCORE	= $E0
D1_SCORE_H	= $E1
D2_SCORE	= $E2
D2_SCORE_H	= $E3

D1_STATE	= $E4
	DUCK_MISSING	= $00
	DUCK_LEFT	= $00
	DUCK_RIGHT	= $80
	DUCK_NORMAL	= $01
	DUCK_MOVE	= $02
	DUCK_FEEDING	= $03
D2_STATE	= $E5

D1_XPOS		= $E6
D2_XPOS		= $E7

D1_YPOS		= $E8
D2_YPOS		= $E9

D1_XSPEED	= $EA
D2_XSPEED	= $EB

D1_YSPEED	= $EC
D2_YSPEED	= $ED

OLD_X		= $EC
OLDER_X		= $ED

DISP_PAGE	= $EE
DRAW_PAGE	= $EF


XPOS		=	$F0
YPOS		=	$F1
XMAX		=	$F2
SPRITE_X	=	$F3
SPRITE_Y	=	$F4
HGR_PAGE	=	$F5
CURRENT_ROW	=	$F6

TEMP		=	$F8
TEMPY		=	$F9
MASKL		=	$FA
MASKH		=	$FB
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

