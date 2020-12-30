
game_over:
	lda	#$a0
	jsr	clear_top_a

	bit	SET_TEXT

	lda	#10
	sta	CV
	lda	#15
	sta	CH

	lda     #>(game_over_man)
        sta     OUTH
        lda     #<(game_over_man)
        sta     OUTL

	jsr	move_and_print

	jsr	page_flip

	jsr	wait_until_keypressed

	rts

game_over_man:
	.asciiz	"GAME OVER"

