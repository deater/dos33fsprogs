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

	lda	#$ff
	sta	LEVEL_OVER

	rts

