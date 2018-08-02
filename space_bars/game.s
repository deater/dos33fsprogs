	;================================
	; Show some instructions
	; return when a key is pressed
	;================================

game:
	;===================
	; init screen
	bit	LORES
	bit	SET_GR
	bit	FULLGR
	bit	KEYRESET

	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE

	lda	#0
	jsr	clear_gr


	jsr	wait_until_keypressed		; tail call?

	rts

