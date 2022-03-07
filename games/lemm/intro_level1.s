
intro_level1:

	lda	#<level1_intro_text
	sta	OUTL
	lda	#>level1_intro_text
	sta	OUTH

	ldx	#8
text_loop:

	jsr	move_and_print

	dex
	bne	text_loop

	jsr	wait_until_keypress

	rts

level1_intro_text:
.byte  0, 8,"LEVEL 1",0
.byte 15, 8,"JUST DIG!",0
.byte  9,13,"NUMBER OF LEMMINGS 10",0
.byte 12,15,"10%  TO BE SAVED",0
.byte 12,17,"RELEASE RATE 50",0
.byte 13,19,"TIME 5 MINUTES",0
.byte 15,21,"RATING FUN",0
.byte  8,23,"PRESS RETURN TO CONINUE",0

.byte  0, 8,"LEVEL 5",0
.byte 15, 8,"YOU NEED BASHERS THIS TIME",0
.byte  9,13,"NUMBER OF LEMMINGS 50",0
.byte 12,15,"10%  TO BE SAVED",0
.byte 12,17,"RELEASE RATE 50",0
.byte 13,19,"TIME 5 MINUTES",0
.byte 15,21,"RATING FUN",0
.byte  8,23,"PRESS RETURN TO CONINUE",0
