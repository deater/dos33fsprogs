; Electric Duet Code Path

still_alive_ed:

	; init variables

	lda	#0
	sta	FRAME_COUNT


	;===========================
	; clear both screens
	;===========================

;	lda	FORTYCOL
;	bne	only_forty_ed

;switch_to_80_ed:

	; Initialize 80 column firmware
;	jsr	$C300			; same as PR#3
;	sta	SET80COL		; 80store  C001
					; makes pageflip switch between
					; regular/aux memory

;only_forty_ed:

	; Clear text page0

;	jsr     HOME


	;============================
	; Draw Lineart around edges
	;============================

;	jsr	setup_edges

;	jsr	HOME

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
