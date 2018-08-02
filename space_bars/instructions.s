	;================================
	; Show some instructions
	; return when a key is pressed
	;================================

instructions:
	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE

	lda	#<inst_text
	sta	OUTL
	lda	#>inst_text
	sta	OUTH

	jsr	move_and_print
	jsr	move_and_print

	jsr	wait_until_keypressed		; tail call?

	rts

;	    0         1         2         3
;	    0123456789012345678901234567890123456789
inst_text:

.byte  6, 0,	 "*** RASTERBARS IN SPACE ***",0

.byte  8, 3,	   "BY VINCE 'DEATER' WEAVER",0

.asciiz      "WWW.DEATER.NET/WEAVE/VMWPROD"

.asciiz "======================================="

.asciiz	     "ARROWS, WASD: STEER"
.asciiz	     "Z: ACCELERATE"
.asciiz	     "SPACE: FIRE"
.asciiz      "ESC: QUITS"

.asciiz      "M: TOGGLE SOUND, CURRENTLY ON"


