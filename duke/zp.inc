;; Zero Page

;; LZSA addresses
NIBCOUNT	= $00

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



; MIST zero page addresses

FRAMEL			= $60
FRAMEH			= $61
CURSOR_X		= $62
CURSOR_Y		= $63
XPOS			= $64
YPOS			= $65
LOCATION_STRUCT_L	= $66
LOCATION_STRUCT_H	= $67
IN_SPECIAL		= $68
CURSOR_VISIBLE		= $69
IN_LEFT			= $6A
IN_RIGHT		= $6B
BTC_L			= $6C
BTC_H			= $6D

; pt3 player registers
REGISTER_DUMP   = $70
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
COPY_OFFSET     = $7E
DECODER_STATE   = $7F

PATTERN_L       = $7E
PATTERN_H       = $7F


; note 70-7f also used by disk code

; note: rest are up at $f0

; We have to save/restore the following values
; when loading/storing from disk

WHICH_LOAD		= $80		; which file to load
LOCATION		= $81		; location on the map

GUYBRUSH_X		= $82		; location of protagonist
GUYBRUSH_Y		= $83

CURRENT_VERB		= $84		; current verb
VALID_NOUN		= $85		; current noun
NOUN_L			= $86		; pointer to current noun string
NOUN_H			= $87
NOUN_VECTOR_L		= $88		; pointer to callback for clicking noun
NOUN_VECTOR_H		= $89

DESTINATION_X		= $8A		; where to walk
DESTINATION_Y		= $8B

; credits stuff
CLOUD_X			= $8C
CREDITS_OFFSET		= $8D
CREDITS_LOGO_ON		= $8E
CREDITS_SPLIT_SCREEN	= $8F
CREDITS_DISPLAY_TEXT	= $90
CREDITS_TEXTL		= $91
CREDITS_TEXTH		= $92

GUYBRUSH_DIRECTION	= $93
	DIR_DOWN = 0	; there's a reason for this
	DIR_LEFT = 2
	DIR_UP   = 4
	DIR_RIGHT= 6

BAR_DOOR_OPEN		= $94
DISPLAY_MESSAGE		= $95
MESSAGE_L		= $96
MESSAGE_H		= $97

GUYBRUSH_SIZE		= $98
	GUYBRUSH_BIG    = 0
	GUYBRUSH_MEDIUM	= 1
	GUYBRUSH_SMALL  = 2
	GUYBRUSH_TINY   = 3
GUYBRUSH_FEET		= $99
ITEMS_PICKED_UP		= $9A
	IPU_ITEM_MEAT = $01
	IPU_ITEM_PULLEY_CHICKEN = $02

	INV_ITEM_MEAT	=		$1
	INV_ITEM_PULLEY_CHICKEN	=	$2

INVENTORY		= $9B
INVENTORY2		= $9C
INVENTORY3		= $9D
INVENTORY4		= $9E
INVENTORY5		= $9F

INVENTORY_NEXT_SLOT	= $A0
FIRST_TIME		= $A1
	FIRST_TIME_LEAVE_LOOKOUT=	$1
	FIRST_TIME_LEAVE_BAR	=	$2
COUNT			= $A2

; done game puzzle state


WHICH_SLOT	=	$DA
JS_BUTTON_STATE	=	$DB
CURRENT_DISK	=	$DC
JOYSTICK_ENABLED=	$DD
SOUND_STATUS	=	$DE
	SOUND_DISABLED	= $80
	SOUND_IN_LC	= $01 ; $01 sound effects in language card
	SOUND_MOCKINGBOARD = $02 ; mockingboard detected

GRID_PAGE	=	$DF
ANIMATE_FRAME	=	$E0
LEVEL_OVER	=	$E1
LOCATIONS_L	=	$E2
LOCATIONS_H	=	$E3

; temp var per-world define
LONG_FRAME	=	$E4	; nibel
CURRENT_DISPLAY	=	$E4	; selena
LAST_PLAYED	=	$E4	; selena

DISP_PAGE	=	$ED	; ALL
DRAW_PAGE	=	$EE	; ALL

; rest of pt3_player
MB_DETECTED	= $EF
WHICH_CHUNK	= $F0
MB_CHUNK_OFFSET	= $F1
LOOP		= $F4
MB_VALUE	= $F5
MB_ADDR_L	= $F6
MB_ADDR_H	= $F7
DONE_PLAYING	= $F8
DONE_SONG	= $F9

; rest of pt3_player
PT3_TEMP        = $EF
ORNAMENT_L      = $F0
ORNAMENT_H      = $F1
SAMPLE_L        = $F2
SAMPLE_H        = $F3






TEMP		=	$FA
TEMPY		=	$FB
INL		=	$FC
INH		=	$FD
OUTL		=	$FE
OUTH		=	$FF

; read any file slot 6 version
; based on FASTLD6 and RTS copyright (c) Peter Ferrie 2011-2013,2018

; modified to assembled with ca64 -- vmw
; added code to patch it to run from current disk slot -- vmw


        adrlo   =       $26     ; constant from boot prom
        adrhi   =       $27     ; constant from boot prom
        tmpsec  =       $3c     ; constant from boot prom
        reqsec  =       $3d     ; constant from boot prom
        sizelo  =       $44
        sizehi  =       $45
        secsize =       $46

        ldsizel =       $70
        ldsizeh =       $71
        namlo   =       $7b
        namhi   =       $7c
        step    =       $7d     ; state for stepper motor
        tmptrk  =       $7e     ; temporary copy of current track
        phase   =       $7f     ; current phase for /seek

