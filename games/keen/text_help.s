; For Help press H

print_help:
	bit	KEYRESET		; clear keyboard
	bit	SET_TEXT

	jsr	normal_text

	lda     #' '|$80
        sta     clear_all_color+1
	jsr	clear_all

	lda	#<help_text
	sta	OUTL
	lda	#>help_text
	sta	OUTH
	jsr	move_and_print_list

	jsr	page_flip

wait_for_keypress:
	lda     KEYPRESS
	bpl	wait_for_keypress
	bit	KEYRESET


	bit	SET_GR
	rts

help_text:
.byte 0, 5,"CONTROLS:",0
.byte 3, 6,   "A OR <-      : MOVE LEFT",0
.byte 3, 7,   "D OR ->      : MOVE RIGHT",0
.byte 3, 8,   "Q            : JUMP LEFT",0
.byte 3, 9,   "E            : JUMP RIGHT",0
.byte 3,10,   "Z            : FINE LEFT",0
.byte 3,11,   "C            : FINE RIGHT",0
.byte 3,12,   "M            : FIRE LASERGUN",0
.byte 3,13,   "P            : POGO",0
.byte 3,15,   "SPACEBAR     : ACTION/JUMP",0
.byte 3,16,   "RETURN       : STATUS BAR",0
.byte 3,17,   "ESC          : QUITS",0
.byte 3,18,   "CONTROL-T    : TOGGLE SOUND",0
.byte 3,19,   "J            : ENABLE JOYSTICK",0
.byte 255
