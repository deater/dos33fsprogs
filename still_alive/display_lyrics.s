
	;============================
	; Setup Word Bounds
	;============================
word_bounds:

	lda	FORTYCOL
	bne	fortycol_word_bounds

eightycol_word_bounds:

	; on 80 column, words go from 2,1 to 35,21

	lda	#2
	sta	WNDLFT
	lda	#35
	sta	WNDWDTH
	lda	#1
	sta	WNDTOP
	lda	#21
	sta	WNDBTM

	rts

fortycol_word_bounds:
	; on 40 column, words go from 1,0 to 35,4

	lda	#1
	sta	WNDLFT
	lda	#35
	sta	WNDWDTH
	lda	#0
	sta	WNDTOP
	lda	#4
	sta	WNDBTM

	rts
