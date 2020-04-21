; init state

; in future we might load from disk

init_state:
	lda	#0

	; book pages
	sta	RED_PAGES_TAKEN
	sta	BLUE_PAGES_TAKEN
	sta	HOLDING_PAGE
	sta	RED_PAGE_COUNT
	sta	BLUE_PAGE_COUNT

	; init clock puzzles
	sta	CLOCK_MINUTE
	sta	CLOCK_HOUR
	sta	CLOCK_TOP
	sta	CLOCK_MIDDLE
	sta	CLOCK_BOTTOM
	sta	CLOCK_COUNT
	sta	CLOCK_LAST

	; init gear
	sta	GEAR_OPEN

	; init generator
	sta	BREAKER_TRIPPED
	sta	GENERATOR_VOLTS
	sta	ROCKET_VOLTS
	sta	GENERATOR_VOLTS_DISP
	sta	ROCKET_VOLTS_DISP
	sta	SWITCH_TOP_ROW
	sta	SWITCH_BOTTOM_ROW
	sta	ROCKET_HANDLE_STEP

	; init rocket sliders
	sta	ROCKET_NOTE1
	sta	ROCKET_NOTE2
	sta	ROCKET_NOTE3
	sta	ROCKET_NOTE4

	; meche elevator
	sta	MECHE_ELEVATOR
	sta	MECHE_ROTATION
	sta	MECHE_LOCK1
	sta	MECHE_LOCK2
	sta	MECHE_LOCK3
	sta	MECHE_LOCK4

	sta	VIEWER_CHANNEL
	sta	VIEWER_LATCHED

	sta	TOWER_ROTATION

	sta	SHIP_RAISED

	sta	PUMP_STATE
	sta	BATTERY_CHARGE
	sta	COMPASS_ANGLE
	sta	CRANK_ANGLE

	lda	#$ff		; for debugging
	sta	MARKER_SWITCHES

	rts
