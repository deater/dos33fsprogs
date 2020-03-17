	;=============================
	; mist_link_book
	;=============================
mist_link_book:

	; play sound effect?
.if 0
	lda	#<audio_link_noise
	sta	BTC_L
	lda	#>audio_link_noise
	sta	BTC_H
	ldx	#43		; 45 pages long???
	jsr	play_audio
.endif
	lda	#1
	sta	LOCATION
	jsr	change_location
	rts

