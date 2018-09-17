; Apple II Megademo

; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"


	;===================
	; set graphics mode
	;===================
	jsr	HOME


	; C64 Opening Sequence

;	jsr	c64_opener

	; Falling Apple II

	jsr	falling_apple

	; Starring Screens

	; E-mail arriving


	;===================
	; do nothing
	;===================
do_nothing:
	jmp	do_nothing


	.include	"lz4_decode.s"
	.include	"c64_opener.s"

