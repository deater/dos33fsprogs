
; Octagon (for playthrough)
.byte LOAD_OCTAGON	; WHICH_LOAD		= 	$80
.byte DIRECTION_S	; DIRECTION		= 	$81
.byte OCTAGON_TEMPLE_CENTER	; LOCATION	=	$82

.byte (OCTAGON_PAGE|MECHE_PAGE|SELENA_PAGE|CHANNEL_PAGE|STONEY_PAGE)
			; RED_PAGES_TAKEN	=	$83
.byte (OCTAGON_PAGE|MECHE_PAGE|SELENA_PAGE|CHANNEL_PAGE|STONEY_PAGE)
			; BLUE_PAGES_TAKEN	=	$84
.byte $1
			; CLOCK_BRIDGE		=	$85
.byte $1
			; GEAR_OPEN		=	$86
.byte (MARKER_DOCK|MARKER_GEARS|MARKER_SPACESHIP|MARKER_GENERATOR|MARKER_CLOCK|MARKER_POOL|MARKER_TREE|MARKER_DENTIST)
			; MARKER_SWITCHES	=	$87
.byte $2
			; CLOCK_HOUR		=	$88
.byte $8
			; CLOCK_MINUTE		=	$89

.byte $00	; TREE_FURNACE_ON	=	$8A
.byte $00	; FIREPLACE_GRID0	=	$8B
.byte $00	; FIREPLACE_GRID1	=	$8C
.byte $00	; FIREPLACE_GRID2	=	$8D
.byte $00	; FIREPLACE_GRID3	=	$8E
.byte $00	; FIREPLACE_GRID4	=	$8F
.byte $00	; FIREPLACE_GRID5	=	$90
.byte $00	; CLOCK_COUNT		=	$91
.byte $00	; CLOCK_TOP		=	$92
.byte $00	; CLOCK_MIDDLE		=	$93
.byte $00	; CLOCK_BOTTOM		=	$94
.byte $00	; CLOCK_LAST		=	$95

.byte $00	; BREAKER_TRIPPED	=	$96
.byte $00	; GENERATOR_VOLTS	=	$97
.byte $00	; ROCKET_VOLTS		=	$98
.byte $00	; SWITCH_TOP_ROW	=	$99
.byte $00	; SWITCH_BOTTOM_ROW 	=	$9A
.byte $00	; GENERATOR_VOLTS_DISP	=	$9B
.byte $00	; ROCKET_VOLTS_DISP	=	$9C
.byte $00	; ROCKET_HANDLE_STEP	=	$9D
.byte $00	; ROCKET_NOTE1		=	$9E
.byte $00	; ROCKET_NOTE2		=	$9F
.byte $00	; ROCKET_NOTE3		=	$A0
.byte $00	; ROCKET_NOTE4		=	$A1
.byte $00	; MECHE_ELEVATOR	=	$A2
.byte $00	; MECHE_ROTATION	=	$A3
.byte $00	; MECHE_LEVERS		=	$A4
.byte $00	; MECHE_LOCK1		=	$A5
.byte $00	; MECHE_LOCK2		=	$A6
.byte $00	; MECHE_LOCK3		=	$A7
.byte $00	; MECHE_LOCK4		=	$A8
.byte $00	; HOLDING_PAGE		=	$A9

.byte $5
		; RED_PAGE_COUNT	=	$AA
.byte $5
		; BLUE_PAGE_COUNT	=	$AB


.byte $00	; VIEWER_CHANNEL	=	$AC
.byte $00	; VIEWER_LATCHED	=	$AD
.byte $4
		; TOWER_ROTATION	=	$AE
.byte $00	; SHIP_RAISED		=	$AF
		; stoneship
.byte $00	; PUMP_STATE		=	$B0
.byte $00	; BATTERY_CHARGE	=	$B1
.byte $00	; COMPASS_ANGLE		=	$B2
.byte $00	; CRANK_ANGLE		=	$B3
.byte $00	; WHITE_PAGE_TAKEN	=	$B4
.byte $00	; CHANNEL_SWITCHES	=	$B5
.byte $00	; CHANNEL_VALVES	=	$B6

.byte $00	; DENTIST_LIGHT		=	$B7
.byte $00	; DENTIST_MONTH		=	$B8
.byte $00	; DENTIST_DAY		=	$B9
.byte $00	; DENTIST_CENTURY	=	$BA
.byte $00	; DENTIST_YEAR		=	$BB
.byte $00	; DENTIST_HOURS		=	$BC
.byte $00	; DENTIST_MINUTES	=	$BD
.byte $00	; PILLAR_ON		=	$BE
.byte $00	; GREEN_BOOK_PROGRESS	=	$BF
.byte $00	; DNI_PROGRESS		=	$C0
.byte $00	; COMPARTMENT_OPEN	=	$C1
.byte $00	; GAME_COMPLETED	=	$C2

.byte $00	; SAFE_HUNDREDS		=	$C3
.byte $00	; SAFE_TENS		=	$C4
.byte $00	; SAFE_ONES		=	$C5
.byte $00	; TREE_LEVEL		=	$C6
.byte $00	; HOLDING_ITEM		=	$C7
.byte $00	; BOILER_VALVE		=	$C8
.byte $00	; TRUNK_STATE		=	$C9

.byte $00       ; SELENA_BUTTON_STATUS  =       $CA
.byte $00       ; SELENA_ANTENNA1       =       $CB
.byte $00       ; SELENA_ANTENNA2       =       $CC
.byte $00       ; SELENA_ANTENNA3       =       $CD
.byte $00       ; SELENA_ANTENNA4       =       $CE
.byte $00       ; SELENA_ANTENNA5       =       $CF
.byte $00       ; SELENA_LOCK1          =       $D0
.byte $00       ; SELENA_LOCK2          =       $D1
.byte $00       ; SELENA_LOCK3          =       $D2
.byte $00       ; SELENA_LOCK4          =       $D3
.byte $00       ; SELENA_LOCK5          =       $D4
.byte $00       ; SELENA_ANTENNA_ACTIVE =       $D5

.byte $00	; SUB_DIRECTION		=	$D6
.byte $00	; SUB_LOCATION		=	$D7
