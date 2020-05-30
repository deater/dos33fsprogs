	;=============================
	; mist_link_book
	;=============================
mist_link_book:

	; clear screen

	lda	#0
	sta	clear_all_color+1

	jsr	clear_all
	jsr	page_flip

	jsr	clear_all
	jsr	page_flip
.if 0
	; play sound effect?

	lda	#<linking_noise
	sta	BTC_L
	lda	#>linking_noise
	sta	BTC_H
	ldx	#LINKING_NOISE_LENGTH		; 45 pages long???
	jsr	play_audio

	lda	#MIST_ARRIVAL_DOCK
	sta	LOCATION

	lda	#LOAD_MIST			; start at Mist
	sta	WHICH_LOAD
.endif

.if 0
	lda	#MECHE_INSIDE_GEAR
	sta	LOCATION
	lda	#LOAD_MECHE
	sta	WHICH_LOAD
	lda	#DIRECTION_E
	sta	DIRECTION
.endif

.if 0
	lda	#MECHE_ROTATE_CONTROLS
	sta	LOCATION
	lda	#LOAD_MECHE
	sta	WHICH_LOAD
	lda	#DIRECTION_E
	sta	DIRECTION
.endif

.if 0
	lda	#SELENA_WALKWAY1
	sta	LOCATION
	lda	#LOAD_SELENA
	sta	WHICH_LOAD
	lda	#DIRECTION_N
	sta	DIRECTION
.endif



	lda	#$ff
	sta	LEVEL_OVER

	rts

