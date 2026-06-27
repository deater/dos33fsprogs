
	;=======================
	;=======================
	; kerrek setup
	;=======================
	;=======================
	; call at beginning of level to setup kerrek state

kerrek_setup:
	; first see if Kerrek alive
	lda	GAME_STATE_3
	and	#KERREK_DEAD
	bne	kerrek_setup_dead

kerrek_setup_alive:
	jsr	random8
	cmp	#205		 ; 80% chance of being there, we approximate 205/256
	bcs	kerrek_alive_not_there

kerrek_alive_out:

	lda	#22			; set up initial kerrek location
	sta	KERREK_X
	sta	PREV_X			; ?
	lda	#76
	sta	KERREK_Y
	sta	PREV_Y
	lda	#1			; original game this is "2"
	sta	KERREK_SPEED

	; clear out fields to default state

	lda	KERREK_STATE
	and	#<(~KERREK_ROW1)
	ora	#KERREK_RIGHT		; init to facing right
	sta	KERREK_STATE

	lda	MAP_LOCATION		; set which map location we are at
	cmp	#LOCATION_KERREK_1
	bne	kerrek_there

	lda	KERREK_STATE
	ora	#KERREK_ROW1
	sta	KERREK_STATE

kerrek_there:

	; play sting
	inc	kerrek_play_sting		; why do it this way?
kerrek_set_there:
	lda	KERREK_STATE
	ora	#KERREK_ONSCREEN
	sta	KERREK_STATE

	rts

	; oh kerrek where art thine sting
kerrek_play_sting:
	.byte	$00

kerrek_alive_not_there:

kerrek_not_there:
kerrek_clear_there:
	lda	KERREK_STATE		; clear the onscreen flag
	and	#<(~KERREK_ONSCREEN)
	sta	KERREK_STATE
	rts

kerrek_setup_dead:

	; see if on this screen

	lda	KERREK_STATE
	and	#KERREK_ROW1
	beq	kerrek_row4
kerrek_row1:
	lda	MAP_LOCATION
	cmp	#LOCATION_KERREK_1
	beq	kerrek_set_there
	bne	kerrek_clear_there

kerrek_row4:
	lda	MAP_LOCATION
	cmp	#LOCATION_KERREK_2
	beq	kerrek_set_there
	bne	kerrek_clear_there

	rts


