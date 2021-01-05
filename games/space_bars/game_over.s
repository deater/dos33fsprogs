	;================================
	; Print Game Over
	;================================

game_over:
	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE

	lda	#<game_over_text
	sta	OUTL
	lda	#>game_over_text
	sta	OUTH

	jsr	move_and_print

	jsr	wait_until_keypressed		; tail call?

	rts

;	    0         1         2         3
;	    0123456789012345678901234567890123456789
game_over_text:

.byte  11, 10,	 "*** GAME OVER ***",0


