;; Zero Page

;; LZSA addresses
NIBCOUNT	= $00
WHICH_LOAD	= $05

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

FRAMEL	= $60
FRAMEH	= $61
CURSOR_X= $62
CURSOR_Y= $63
XPOS	= $64
YPOS	= $65
DIRECTION = $66
	DIRECTION_N = $1
	DIRECTION_S = $2
	DIRECTION_E = $4
	DIRECTION_W = $8
	DIRECTION_ANY=$f
	DIRECTION_ONLY_POINT = $40	; do not change pointer to grab
	DIRECTION_SPLIT = $80		; split text/graphics
LOCATION = $67
LOCATION_STRUCT_L = $68
LOCATION_STRUCT_H = $69
IN_SPECIAL	=	$6A
CURSOR_VISIBLE	=	$6B
IN_LEFT		=	$6C
IN_RIGHT	=	$6D
BTC_L		=	$6E
BTC_H		=	$6F

; If we ever support save to disk, we'd have to save/restore
; the following values

RED_PAGES_TAKEN	=	$80
	OCTAGON_PAGE = 1
	MECHE_PAGE   = 2
	SELENA_PAGE  = 4
	STONEY_PAGE  = 8
	CHANNEL_PAGE = 16
	FINAL_PAGE   = 32
BLUE_PAGES_TAKEN=	$81
CLOCK_BRIDGE	=	$82
GEAR_OPEN	=	$83
MARKER_SWITCHES	=	$84
	MARKER_DOCK      = $01
	MARKER_GEARS     = $02
	MARKER_SPACESHIP = $04
	MARKER_GENERATOR = $08
	MARKER_CLOCK     = $10
	MARKER_TREE      = $20
	MARKER_POOL      = $40
	MARKER_DENTIST   = $80
	
CLOCK_HOUR	=	$85
CLOCK_MINUTE	=	$86
TREE_FURNACE_ON	=	$87
FIREPLACE_GRID0	=	$88
FIREPLACE_GRID1	=	$89
FIREPLACE_GRID2	=	$8A
FIREPLACE_GRID3	=	$8B
FIREPLACE_GRID4	=	$8C
FIREPLACE_GRID5	=	$8D
CLOCK_COUNT	=	$8E
CLOCK_TOP	=	$8F
CLOCK_MIDDLE	=	$90
CLOCK_BOTTOM	=	$91
CLOCK_LAST	=	$92

BREAKER_TRIPPED	=	$93
GENERATOR_VOLTS	=	$94
ROCKET_VOLTS	=	$95
SWITCH_TOP_ROW	=	$96
SWITCH_BOTTOM_ROW =	$97
GENERATOR_VOLTS_DISP =	$98
ROCKET_VOLTS_DISP =	$99
ROCKET_HANDLE_STEP =	$9A
ROCKET_NOTE1	=	$9B
ROCKET_NOTE2	=	$9C
ROCKET_NOTE3	=	$9D
ROCKET_NOTE4	=	$9E
MECHE_ELEVATOR	=	$9F
MECHE_ROTATION	=	$A0
MECHE_LEVERS	=	$A1
	LEFT_LEVER = 1
	RIGHT_LEVER = 2
MECHE_LOCK1	=	$A2
MECHE_LOCK2	=	$A3
MECHE_LOCK3	=	$A4
MECHE_LOCK4	=	$A5
HOLDING_PAGE	=	$A6
	HOLDING_RED_PAGE = $80
	HOLDING_BLUE_PAGE = $40
	HOLDING_WHITE_PAGE = $C0
RED_PAGE_COUNT	=	$A7
BLUE_PAGE_COUNT	=	$A8
VIEWER_CHANNEL	=	$A9
VIEWER_LATCHED	=	$AA
TOWER_ROTATION	=	$AB
	ROTATION_GEARS = 2
	ROTATION_DOCK  = 3
	ROTATION_TREE  = 4
	ROTATION_SPACESHIP = 8
SHIP_RAISED	=	$AC
; stoneship
PUMP_STATE	=	$AD
BATTERY_CHARGE	=	$AE
COMPASS_ANGLE	=	$AF
CRANK_ANGLE	=	$B0
WHITE_PAGE_TAKEN=	$B1
CHANNEL_SWITCHES=	$B2
	CHANNEL_BRIDGE_UP	= $01
	CHANNEL_PIPE_EXTENDED	= $02
	CHANNEL_BOOK_ELEVATOR_UP= $04
	CHANNEL_SW_WINDMILL	= $40
	CHANNEL_SW_FAUCET	= $80
CHANNEL_VALVES	=	$B3
	CHANNEL_VALVE1		= $01
	CHANNEL_VALVE2		= $02
	CHANNEL_VALVE3		= $04
	CHANNEL_VALVE4		= $08
	CHANNEL_VALVE5		= $10
	CHANNEL_VALVE6		= $20



; done game puzzle state


ANIMATE_FRAME	=	$E0
LEVEL_OVER	=	$E1
LOCATIONS_L	=	$E2
LOCATIONS_H	=	$E3

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

