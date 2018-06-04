; Electric Duet Code Path

still_alive_ed:

	; init variables

	lda	#0
	sta	FRAME_COUNT

	lda	#1
	sta	FORTYCOL

	;===========================
	; clear both screens
	;===========================

	; Clear text page0

;	jsr	HOME


	;============================
	; Draw Lineart around edges
	;============================

	jsr	setup_edges

	jsr	HOME

	;==============================
	; Setup lyrics
	;==============================

	lda	#<(lyrics)
	sta	LYRICSL
	lda	#>(lyrics)
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

forever_loop_ed:
	jmp	forever_loop_ed



