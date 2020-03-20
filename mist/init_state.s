; init state

; in future we might load from disk

init_state:
	lda	#0

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

	rts
