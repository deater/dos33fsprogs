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


; We have to save/restore the following values
; when loading/storing from disk

WHICH_LOAD		= $80
DIRECTION		= $81
	DIRECTION_N = $1
	DIRECTION_S = $2
	DIRECTION_E = $4
	DIRECTION_W = $8
	DIRECTION_ANY=$f
	DIRECTION_ONLY_POINT = $40	; do not change pointer to grab
	DIRECTION_SPLIT = $80		; split text/graphics
LOCATION		= $82

RED_PAGES_TAKEN		= $83
	OCTAGON_PAGE = 1
	MECHE_PAGE   = 2
	SELENA_PAGE  = 4
	STONEY_PAGE  = 8
	CHANNEL_PAGE = 16
	FINAL_PAGE   = 32
BLUE_PAGES_TAKEN=	$84
CLOCK_BRIDGE	=	$85
GEAR_OPEN	=	$86
MARKER_SWITCHES	=	$87
	MARKER_DOCK      = $01
	MARKER_GEARS     = $02
	MARKER_SPACESHIP = $04
	MARKER_GENERATOR = $08
	MARKER_CLOCK     = $10
	MARKER_TREE      = $20
	MARKER_POOL      = $40
	MARKER_DENTIST   = $80
	
CLOCK_HOUR	=	$88
CLOCK_MINUTE	=	$89
TREE_FURNACE_ON	=	$8A
FIREPLACE_GRID0	=	$8B
FIREPLACE_GRID1	=	$8C
FIREPLACE_GRID2	=	$8D
FIREPLACE_GRID3	=	$8E
FIREPLACE_GRID4	=	$8F
FIREPLACE_GRID5	=	$90
CLOCK_COUNT	=	$91
CLOCK_TOP	=	$92
CLOCK_MIDDLE	=	$93
CLOCK_BOTTOM	=	$94
CLOCK_LAST	=	$95

BREAKER_TRIPPED	=	$96
GENERATOR_VOLTS	=	$97
ROCKET_VOLTS	=	$98
SWITCH_TOP_ROW	=	$99
SWITCH_BOTTOM_ROW =	$9A
GENERATOR_VOLTS_DISP =	$9B
ROCKET_VOLTS_DISP =	$9C
ROCKET_HANDLE_STEP =	$9D
ROCKET_NOTE1	=	$9E
ROCKET_NOTE2	=	$9F
ROCKET_NOTE3	=	$A0
ROCKET_NOTE4	=	$A1
MECHE_ELEVATOR	=	$A2
MECHE_ROTATION	=	$A3
MECHE_LEVERS	=	$A4
	LEFT_LEVER = 1
	RIGHT_LEVER = 2
MECHE_LOCK1	=	$A5
MECHE_LOCK2	=	$A6
MECHE_LOCK3	=	$A7
MECHE_LOCK4	=	$A8
HOLDING_PAGE	=	$A9
	HOLDING_RED_PAGE = $80
	HOLDING_BLUE_PAGE = $40
	HOLDING_WHITE_PAGE = $C0
RED_PAGE_COUNT	=	$AA
BLUE_PAGE_COUNT	=	$AB
VIEWER_CHANNEL	=	$AC
VIEWER_LATCHED	=	$AD
TOWER_ROTATION	=	$AE
	ROTATION_GEARS = 2
	ROTATION_DOCK  = 3
	ROTATION_TREE  = 4
	ROTATION_SPACESHIP = 8
SHIP_RAISED	=	$AF
; stoneship
PUMP_STATE	=	$B0
BATTERY_CHARGE	=	$B1
COMPASS_ANGLE	=	$B2
CRANK_ANGLE	=	$B3
WHITE_PAGE_TAKEN=	$B4
CHANNEL_SWITCHES=	$B5
	CHANNEL_BRIDGE_UP	= $01
	CHANNEL_PIPE_EXTENDED	= $02
	CHANNEL_BOOK_ELEVATOR_UP= $04
	CHANNEL_SW_GATE_TOP	= $08
	CHANNEL_ELEVATOR1_UP	= $10
	CHANNEL_SW_GATE_BOTTOM	= $20
	CHANNEL_SW_WINDMILL	= $40
	CHANNEL_SW_FAUCET	= $80
CHANNEL_VALVES	=	$B6
	CHANNEL_VALVE1		= $01
	CHANNEL_VALVE2		= $02
	CHANNEL_VALVE3		= $04
	CHANNEL_VALVE4		= $08
	CHANNEL_VALVE5		= $10
	CHANNEL_VALVE6		= $20
DENTIST_LIGHT	=	$B7
DENTIST_MONTH	=	$B8
DENTIST_DAY	=	$B9
DENTIST_CENTURY	=	$BA
DENTIST_YEAR	=	$BB
DENTIST_HOURS	=	$BC
DENTIST_MINUTES	=	$BD
PILLAR_ON	=	$BE
	PILLAR_EYE		= $01
	PILLAR_SNAKE		= $02
	PILLAR_BUG		= $04
	PILLAR_ANCHOR		= $08
	PILLAR_ARROW		= $10
	PILLAR_LEAF		= $20
	PILLAR_CROSS		= $40
	PILLAR_EMU		= $80
GREEN_BOOK_PROGRESS	= $BF

END_OF_SAVE	=	$C0


; done game puzzle state


GRID_PAGE	=	$DF
ANIMATE_FRAME	=	$E0
LEVEL_OVER	=	$E1
LOCATIONS_L	=	$E2
LOCATIONS_H	=	$E3
LONG_FRAME	=	$E4

DISP_PAGE	=	$ED	; ALL
DRAW_PAGE	=	$EE	; ALL


TINL		=	$F0
TINH		=	$F1
BINL		=	$F2
BINH		=	$F3


SCROLL_COUNT	=	$F9
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

