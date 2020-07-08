;=======================
; flip circuit breaker

; if room==MIST_TOWER2_TOP, and with #$fe
; if room==MIST_TOWER1_TOP, and with #$fd

circuit_breaker:

	bit	$C030		; click speaker

	lda	LOCATION
	cmp	#MIST_TOWER2_TOP
	bne	other_circuit_breaker

	lda	BREAKER_TRIPPED
	and	#$fe
	jmp	done_circuit_breaker

other_circuit_breaker:
	lda	BREAKER_TRIPPED
	and	#$fd

done_circuit_breaker:
	sta	BREAKER_TRIPPED

	bne	done_turn_on_breaker

turn_on_breaker:

	lda	GENERATOR_VOLTS
	cmp	#$60
	bcs	done_turn_on_breaker

	sta	ROCKET_VOLTS
	sta	ROCKET_VOLTS_DISP


done_turn_on_breaker:

	rts


;======================
; open the spaceship door

open_ss_door:

	; check if voltage is 59
	lda	ROCKET_VOLTS
	cmp	#$59
	bne	done_ss_door

	; change to open door image
	ldy	#LOCATION_NORTH_BG
	lda	#<spaceship_door_open_n_lzsa
	sta	location26,Y				; MIST_ROCKET_CLOSE
	lda	#>spaceship_door_open_n_lzsa
	sta	location26+1,Y				; MIST_ROCKET_CLOSE

	; change to load new level if through
	ldy	#LOCATION_SPECIAL_FUNC
	lda	#<(go_to_selena-1)
	sta	location26,Y				; MIST_ROCKET_CLOSE
	lda	#>(go_to_selena-1)
	sta	location26+1,Y				; MIST_ROCKET_CLOSE

	jsr	change_location

done_ss_door:
	rts


;======================
; go to selena
;======================

go_to_selena:

	lda	#LOAD_SELENA		; Selena
	sta	WHICH_LOAD

	lda	#$ff
	sta	LEVEL_OVER

	rts

;======================
; go to generator
;======================

go_to_generator:

	lda	CURSOR_X
	cmp	#27
	bcs	goto_tower

	cmp	#13
	bcs	goto_shack

marker_switch:
	; FIXME
	rts

goto_shack:
	lda	#GEN_GREEN_SHACK
	jmp	into_generator

goto_tower:
	lda	#GEN_TOWER1_TRAIL

into_generator:
	sta	LOCATION

	lda	#LOAD_GENERATOR		; Selena
	sta	WHICH_LOAD

	lda	#$ff
	sta	LEVEL_OVER

	rts






