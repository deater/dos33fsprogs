; Electric Duet Code Path

still_alive_ed:

	; init variables

	lda	#0
	sta	FRAME_COUNT


	;============================
	; Draw Lineart around edges
	;============================

	jsr	setup_edges

	jsr	HOME

	;==============================
	; Setup lyrics
	;==============================

	lda	#<(lyrics_ed)
	sta	LYRICSL
	lda	#>(lyrics_ed)
	sta	LYRICSH


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
