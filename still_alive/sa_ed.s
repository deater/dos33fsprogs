; Electric Duet Code Path

still_alive_ed:

	; init variables

	lda	#0
	sta	FRAME_COUNT

	;==============================
	; Setup lyrics
	;==============================

	; DANGER!  1 in 256 chance of missing a roll-over


	; ED offsets are one after the MB offsets

	inc	LYRICSL

;	lda	#<(lyrics_ed)
;	sta	LYRICSL
;	lda	#>(lyrics_ed)
;	sta	LYRICSH


	;==================
	; load song
	;==================
	lda	#<music_address
	sta	MADDRL
	lda	#>music_address
	sta	MADDRH

	jsr	play_ed

	;==================
	; loop forever
	;==================

	rts
