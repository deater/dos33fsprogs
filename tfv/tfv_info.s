
game_over:
	rts

print_help:
	lda	#$a0
	jsr	clear_top_a

	bit	SET_TEXT

	lda	#1
	sta	CV
	lda	#18
	sta	CH

	lda     #>(help1)
        sta     OUTH
        lda     #<(help1)
        sta     OUTL

	jsr	move_and_print
	jsr	point_to_end_string

	lda	#3
	sta	CV
	lda	#4
	sta	CH

help_loop:
	jsr	move_and_print
	jsr	point_to_end_string
	inc	CV

	lda	#11
	cmp	CV
	bne	help_loop

	jsr	page_flip

	jsr	wait_until_keypressed

	bit     SET_GR                  ; set graphics

	rts

help1:	.asciiz "HELP"
help2:	.asciiz "ARROWS  - MOVE"
help3:	.asciiz "W/A/S/D - MOVE"
help4:	.asciiz "Z/X     - SPEED UP / SLOW DOWN"
help5:	.asciiz "SPACE   - STOP"
help6:	.asciiz "RETURN  - LAND / ENTER / ACTION"
help7:	.asciiz "I       - INVENTORY"
help8:	.asciiz "M       - MAP"
help9:	.asciiz "ESC     - QUIT"

