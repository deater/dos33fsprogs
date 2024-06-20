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

SEEDL	= $4e
SEEDH	= $4f
XMAX	= $50


; note 70-7f used by disk code (?) do we need to preserve?

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

MAGLEV_FLIP_DIRECTION	= $A0
BEACH_ANIMALS_SEEN	= $A1

TEMP		=	$F9
MASKL		=	$FA
MASKH		=	$FB
INL		=	$FC
INH		=	$FD
OUTL		=	$FE
OUTH		=	$FF

