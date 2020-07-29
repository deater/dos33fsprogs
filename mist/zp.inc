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

; note 70-7f also used by disk code

; note: rest are up at $f0

; We have to save/restore the following values
; when loading/storing from disk

WHICH_LOAD		= $80		; which file to load
DIRECTION		= $81		; direction we are pointing
	DIRECTION_N = $1
	DIRECTION_S = $2
	DIRECTION_E = $4
	DIRECTION_W = $8
	DIRECTION_ANY=$f
	DIRECTION_ONLY_POINT = $40	; do not change pointer to grab
	DIRECTION_SPLIT = $80		; split text/graphics

LOCATION		= $82		; location on the map

RED_PAGES_TAKEN		= $83		; red pages that have been picked up
	OCTAGON_PAGE = $01
	MECHE_PAGE   = $02
	SELENA_PAGE  = $04
	STONEY_PAGE  = $08
	CHANNEL_PAGE = $10
	FINAL_PAGE   = $20
BLUE_PAGES_TAKEN=	$84		; blue pages that have been picked up
CLOCK_BRIDGE	=	$85		; is the clock island bridge raised
GEAR_OPEN	=	$86		; is the big gear open
MARKER_SWITCHES	=	$87		; state of the marker switches
	MARKER_DOCK      = $01
	MARKER_GEARS     = $02
	MARKER_SPACESHIP = $04
	MARKER_GENERATOR = $08
	MARKER_CLOCK     = $10
	MARKER_TREE      = $20
	MARKER_POOL      = $40
	MARKER_DENTIST   = $80
	
CLOCK_HOUR	=	$88		; hour on the mist clock
CLOCK_MINUTE	=	$89		; minute on the mist clock

BOILER_LEVEL	=	$8A		; furnace in the cabin level

FIREPLACE_GRID0	=	$8B		; fireplace grid puzzle state
FIREPLACE_GRID1	=	$8C
FIREPLACE_GRID2	=	$8D
FIREPLACE_GRID3	=	$8E
FIREPLACE_GRID4	=	$8F
FIREPLACE_GRID5	=	$90

CLOCK_COUNT	=	$91		; clock puzzle (turns taken)
CLOCK_TOP	=	$92		; clock puzzle (top dial)
CLOCK_MIDDLE	=	$93		; clock puzzle (middle dial)
CLOCK_BOTTOM	=	$94		; clock puzzle (bottom dial)
CLOCK_LAST	=	$95		; clock puzzle (last dial turned)

BREAKER_TRIPPED	=	$96		; generator (circuit breakers status)
GENERATOR_VOLTS	=	$97		; generator (total volts)
ROCKET_VOLTS	=	$98		; generator (rocket volts)
SWITCH_TOP_ROW	=	$99		; generator (switch top row)
SWITCH_BOTTOM_ROW =	$9A		; generator (switch bottom row)
GENERATOR_VOLTS_DISP =	$9B		; generator (total volts on display)
ROCKET_VOLTS_DISP =	$9C		; generator (rocket volts on display)

ROCKET_HANDLE_STEP =	$9D		; organ (which knob is lit) [why zp?]
ROCKET_NOTE1	=	$9E		; organ (note slider 1)
ROCKET_NOTE2	=	$9F		; organ (note slider 2)
ROCKET_NOTE3	=	$A0		; organ (note slider 3)
ROCKET_NOTE4	=	$A1		; organ (note slider 4)

MECHE_ELEVATOR	=	$A2		; fortress elevator state
MECHE_ROTATION	=	$A3		; fortress rotation state
MECHE_LEVERS	=	$A4		; fortress rotation levers
	LEFT_LEVER = 1
	RIGHT_LEVER = 2
MECHE_LOCK1	=	$A5		; meche lock symbol1
MECHE_LOCK2	=	$A6		; meche lock symbol2
MECHE_LOCK3	=	$A7		; meche lock symbol3
MECHE_LOCK4	=	$A8		; meche lock symbol4

HOLDING_PAGE	=	$A9		; which page in hand
	HOLDING_RED_PAGE	= $80
	HOLDING_BLUE_PAGE	= $40
	HOLDING_WHITE_PAGE	= $C0
	;FINAL_PAGE   = $20
	;CHANNEL_PAGE = $10
	;STONEY_PAGE  = $08
	;SELENA_PAGE  = $04
	;MECHE_PAGE   = $02
	;OCTAGON_PAGE = $01

RED_PAGE_COUNT	=	$AA		; # of red pages in book
BLUE_PAGE_COUNT	=	$AB		; # of blue pages in book

VIEWER_CHANNEL	=	$AC		; viewer: current channel
VIEWER_LATCHED	=	$AD		; viewer: latched channel

TOWER_ROTATION	=	$AE		; tower rotation: which
	ROTATION_GEARS = 2
	ROTATION_DOCK  = 3
	ROTATION_TREE  = 4
	ROTATION_SPACESHIP = 8

SHIP_RAISED	=	$AF		; ship raised or not

PUMP_STATE	=	$B0		; stoneship pump state
BATTERY_CHARGE	=	$B1		; stoneship battery charge
COMPASS_ANGLE	=	$B2		; stoneship compass angle
CRANK_ANGLE	=	$B3		; stoneship crank angle

WHITE_PAGE_TAKEN=	$B4		; white page taken

CHANNEL_SWITCHES=	$B5		; channelwood switches
	CHANNEL_SW_FAUCET	= $80
	CHANNEL_SW_WINDMILL	= $40
	CHANNEL_SW_GATE_BOTTOM	= $20
	CHANNEL_ELEVATOR1_UP	= $10
	CHANNEL_SW_GATE_TOP	= $08
	CHANNEL_BOOK_ELEVATOR_UP= $04
	CHANNEL_PIPE_EXTENDED	= $02
	CHANNEL_BRIDGE_UP	= $01

CHANNEL_VALVES	=	$B6		; channelwood valves
	CHANNEL_VALVE1		= $01		; elevator2
	CHANNEL_VALVE2		= $02		; big tree
	CHANNEL_VALVE3		= $04		; broken
	CHANNEL_VALVE4		= $08		; elevator1
	CHANNEL_VALVE5		= $10		; entry
	CHANNEL_VALVE6		= $20		; bridge

DENTIST_LIGHT	=	$B7		; dentist lightswitch
DENTIST_MONTH	=	$B8		; dentist panel: month
DENTIST_DAY	=	$B9		; dentist panel: day
DENTIST_CENTURY	=	$BA		; dentist panel: century
DENTIST_YEAR	=	$BB		; dentist panel: year
DENTIST_HOURS	=	$BC		; dentist panel: hours
DENTIST_MINUTES	=	$BD		; dentist panel: minutes

PILLAR_ON	=	$BE		; pillars: which on/off
	PILLAR_EYE		= $01
	PILLAR_SNAKE		= $02
	PILLAR_BUG		= $04
	PILLAR_ANCHOR		= $08
	PILLAR_ARROW		= $10
	PILLAR_LEAF		= $20
	PILLAR_CROSS		= $40
	PILLAR_EMU		= $80

GREEN_BOOK_PROGRESS	= $BF		; green book: what's ben seen

DNI_PROGRESS		= $C0		; dni: atrus status

COMPARTMENT_OPEN	= $C1		; dock marker switch compartment

GAME_COMPLETE		= $C2		; game has been completed

SAFE_HUNDREDS		= $C3		; safe combination, hundreds
SAFE_TENS		= $C4		; safe combination, tens
SAFE_ONES		= $C5		; safe combination, ones

TREE_LEVEL		= $C6		; how high is the tree hole

HOLDING_ITEM		= $C7
	HOLDING_KEY		= $04
	HOLDING_LIT_MATCH	= $02
	HOLDING_MATCH		= $01

BOILER_VALVE		= $C8		; how many turns of the boiler valve

TRUNK_STATE		= $C9		; trunk state in stonsehip
	TRUNK_VALVE_OPEN    = $01
	TRUNK_WATER_DRAINED = $02
	TRUNK_KEY_TAKEN	    = $04
	TRUNK_HATCH_OPEN    = $08

SELENA_BUTTON_STATUS	= $CA
	SELENA_BUTTON1	=	$01
	SELENA_BUTTON2	=	$02
	SELENA_BUTTON3	=	$04
	SELENA_BUTTON4	=	$08
	SELENA_BUTTON5	=	$10


SELENA_ANTENNA1		= $CB
SELENA_ANTENNA2		= $CC
SELENA_ANTENNA3		= $CD
SELENA_ANTENNA4		= $CE
SELENA_ANTENNA5		= $CF

SELENA_LOCK1		= $D0
SELENA_LOCK2		= $D1
SELENA_LOCK3		= $D2
SELENA_LOCK4		= $D3
SELENA_LOCK5		= $D4

SELENA_ANTENNA_ACTIVE	= $D5

END_OF_SAVE	=	$D6


; done game puzzle state




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
LONG_FRAME	=	$E4
CURRENT_DISPLAY	=	$E4

DISP_PAGE	=	$ED	; ALL
DRAW_PAGE	=	$EE	; ALL

; rest of pt3_player
PT3_TEMP        = $EF
ORNAMENT_L      = $F0
ORNAMENT_H      = $F1
SAMPLE_L        = $F2
SAMPLE_H        = $F3
LOOP            = $F4
MB_VALUE        = $F5
MB_ADDR_L       = $F6
MB_ADDR_H       = $F7
DONE_PLAYING    = $F8
DONE_SONG       = $F9

;TINL		=	$F0
;TINH		=	$F1
;BINL		=	$F2
;BINH		=	$F3
;SCROLL_COUNT	=	$F9

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

