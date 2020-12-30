	;====================
	; print help message
	;====================

print_help:
	lda	#$a0
	jsr	clear_top_a

	bit	SET_TEXT

	lda     #>(help_message)
        sta     OUTH
        lda     #<(help_message)
        sta     OUTL

	jsr	move_and_print_list

	jsr	page_flip

	jsr	wait_until_keypressed

	bit     SET_GR                  ; set graphics

	rts

help_message:
	.byte 1,18,"HELP"
	.byte 3,4,"ARROWS  - MOVE"
	.byte 3,5,"W/A/S/D - MOVE"
	.byte 3,6,"Z/X     - SPEED UP / SLOW DOWN"
	.byte 3,7,"SPACE   - STOP"
	.byte 3,8,"RETURN  - LAND / ENTER / ACTION"
	.byte 3,9,"I       - INVENTORY"
	.byte 3,10,"M       - MAP"
	.byte 3,11,"ESC     - QUIT"
	.byte $ff
