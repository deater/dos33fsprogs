	;===============================
	; print help message when flying
	;===============================

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
	.byte 14,1,"FLYING HELP",0
	.byte 3,4, "A/D,<-/->    - TURN",0
	.byte 3,5, "W/S,UP/DOWN  - CHANGE ALTITUDE",0
	.byte 3,6, "Z/X          - SPEED UP / SLOW DOWN",0
	.byte 3,7, "SPACE        - STOP",0
	.byte 3,8, "RETURN       - LAND",0
	.byte 3,11,"Q,ESC        - QUIT",0
	.byte 3,12,"J            - ENABLE JOYSTICK",0
	.byte 3,13,"CONTROL-T    - TOGGLE SOUND",0
	.byte $ff
