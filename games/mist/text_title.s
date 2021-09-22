.include "common_defines.inc"
.include "zp.inc"
.include "hardware.inc"

text_title:
	jsr	TEXT
	jsr	HOME

	lda	#0
	sta	DRAW_PAGE

	; print non-inverse
	lda	#$80
	sta	ps_smc1+1

	lda	#09		; ora
	sta	ps_smc1

	lda	#<boot_message
	sta	OUTL
	lda	#>boot_message
	sta	OUTH

	ldx	#15
text_loop:

	jsr	move_and_print

	dex
	bne	text_loop

;	lda	#40
;	jsr	wait_a_bit

	rts

;             0123456789012345678901234567890123456789
boot_message:
.byte	0,0, "LOADING MIST V1.02",0
.byte	0,3, "CONTROLS:",0
.byte	5,4, "MOVE CURSOR    : ARROWS OR WASD",0
.byte	5,5, "FORWARD/ACTION : RETURN OR SPACE",0
.byte	5,7, "ENABLE JOYSTICK: J",0
.byte	5,8, "LOAD GAME      : CONTROL-L",0
.byte	5,9, "SAVE           : CONTROL-S",0
.byte	5,10,"TOGGLE SOUND   : CONTROL-T",0
.byte	0,13,"BASED ON MYST BY CYAN INC",0
.byte	0,14,"APPLE II PORT: VINCE WEAVER",0
.byte	0,15,"DISK CODE    : QKUMBA",0
.byte	0,16,"SOUND CODE   : OLIVER SCHMIDT",0
.byte	0,17,"LZSA CODE    : EMMANUEL MARTY",0
.byte	7,19,"______",0
.byte	5,20,"A \/\/\/ SOFTWARE PRODUCTION",0

.include	"text_print.s"
.include	"gr_offsets.s"
.include	"wait_a_bit.s"
