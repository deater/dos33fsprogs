;; Zero Page

;; ZX02 addresses

ZP=$00

offset          = ZP+0
ZX0_src         = ZP+2
ZX0_dst         = ZP+4
bitr            = ZP+6
pntr            = ZP+7

; disk code

NIBCOUNT        = $09
CURRENT_DRIVE   = $0A
DRIVE1_DISK     = $0B
DRIVE2_DISK     = $0C
DRIVE1_TRACK    = $0D
DRIVE2_TRACK    = $0E
NEW_DISK_BCD	= $0F
BTC_L		= $10
BTC_H		= $11

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
X_LEFT	= $2C
V2	= $2D
MASK	= $2E
COLOR_MASK = $2F
COLOR	= $30


	; this is the structure for a ProDOS smartport command, at least
	; for a read (command=1)

	COMMAND = $42		; ProDOS constant
	UNIT    = $43		; ProDOS constant
	ADRLO   = $44		; ProDOS constant
	ADRHI   = $45		; ProDOS constant
	BLOKLO  = $46		; ProDOS constant
	BLOKHI  = $47		; ProDOS constant



SEEDL	= $4e
SEEDH	= $4f
XMAX	= $50



; We have to save/restore the following values
; when loading/storing from disk

WHICH_LOAD		= $80		; which file to load

DIRECTION		= $81
	DIRECTION_N = $1
	DIRECTION_S = $2
	DIRECTION_E = $4
	DIRECTION_W = $8
	DIRECTION_ANY=$f
	DIRECTION_ONLY_POINT = $40	; do not change pointer to grab
	DIRECTION_SPLIT = $80		; split text/graphics

LOCATION		= $82

JS_BUTTON_STATE		= $83
CURRENT_DISK		= $84
JOYSTICK_ENABLED	= $85
SOUND_STATUS		= $86
		SOUND_DISABLED	= $80
		SOUND_IN_LC	= $01 ; $01 sound effects in language card
		SOUND_MOCKINGBOARD = $02 ; mockingboard detected

SCENE_COUNT		= $87
ANIMATE_FRAME		= $88
LEVEL_OVER		= $89
		NEXT_LEVEL	= $01
		NEXT_DISK	= $80
LOCATIONS_L		= $8A
LOCATIONS_H		= $8B

DISP_PAGE		= $8C
DRAW_PAGE		= $8D

WHICH_OVERLAY		= $8E
NEW_GAME		= $8F


; Riven zero page addresses

FRAMEL			= $90
FRAMEH			= $91
CURSOR_X		= $92
CURSOR_Y		= $93
XPOS			= $94
YPOS			= $95
LOCATION_STRUCT_L	= $96
LOCATION_STRUCT_H	= $97
IN_SPECIAL		= $98
CURSOR_VISIBLE		= $99
IN_LEFT			= $9A
IN_RIGHT		= $9B
UPDATE_POINTER		= $9C
APPLEII_MODEL		= $9D
HGR_PAGE		= $9E
WHICH_SLOT		= $9F

SPRITEX			= $A0
SPRITEY			= $A1
DRAW_NUMBER		= $A2
NUMBER_LOW		= $A3
NUMBER_HIGH		= $A4

;=============================
; Riven Game State
;=============================

STATE_MAGLEV	=	$B0
	MAGLEV1_LOCATION	=	$01	; 0 = initial
	MAGLEV2_LOCATION	=	$02	; 1 = far away
	MAGLEV3_LOCATION	=	$04
	MAGLEV1_DIRECTION	=	$10	; 0 = inbound
	MAGLEV2_DIRECTION	=	$20	; 1 = outbound
	MAGLEV3_DIRECTION	=	$40


	; other doors?  to scanner room?
	; fish mouth
STATE_DOORS	=	$B1
	TEMPLE_DOOR		=	$01	; 0 = closed, 1 = open

	; other:
	; two switches in rotate room
	; telescope power
STATE_SWITCHES	=	$B2
	CHAIR_OPEN		=	$01	; 0 = down, 1 = up


STATE_EVENTS	=	$B3
	BEACH_ANIMALS_SEEN	=	$01


ROOM_ROTATION		= $B4
WHICH_PILLAR		= $B5

COUNT		=	$F7
TEMPY		=	$F8
TEMP		=	$F9
MASKL		=	$FA
MASKH		=	$FB
INL		=	$FC
INH		=	$FD
OUTL		=	$FE
OUTH		=	$FF

