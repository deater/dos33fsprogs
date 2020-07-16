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

	; play sound effect

	jsr	play_link_noise

	lda	#MIST_ARRIVAL_DOCK
	sta	LOCATION

	lda	#LOAD_MIST			; start at Mist
	sta	WHICH_LOAD

	lda	#$ff
	sta	LEVEL_OVER

	rts

