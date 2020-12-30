	;====================
	; print help message
	;====================

print_help:

	lda	#$a0
	jsr	clear_top_a

	bit	SET_TEXT

	jsr	normal_text

        lda     #<(help_message)
        sta     OUTL
	lda     #>(help_message)
        sta     OUTH

	jsr	move_and_print_list

	jsr	page_flip

	jsr	wait_until_keypressed

	bit     SET_GR                  ; set graphics

	rts

help_message:
	.byte 1,18,"HELP",0
	.byte 3,4,"ARROWS  - MOVE",0
	.byte 3,5,"W/A/S/D - MOVE",0
	.byte 3,6,"Z/X     - SPEED UP / SLOW DOWN",0
	.byte 3,7,"SPACE   - STOP",0
	.byte 3,8,"RETURN  - LAND / ENTER / ACTION",0
	.byte 3,9,"I       - INVENTORY",0
	.byte 3,10,"M       - MAP",0
	.byte 3,11,"ESC     - QUIT",0
	.byte $ff
