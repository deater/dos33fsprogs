; For Help press ^H

print_help:
	bit	KEYRESET		; clear keyboard
	bit	SET_TEXT

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
.byte 3, 8,   "SPACEBAR     : JUMP",0
.byte 3,11,   "RETURN       : SHOOT LASER",0
.byte 3,12,   "ESC          : QUITS",0
.byte 255
