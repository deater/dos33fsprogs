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
	; Loop Forever
	;===================
loop_forever:
	jmp	loop_forever


	.include	"lz4_decode.s"
	.include	"c64_opener.s"
	.include	"falling_apple.s"
	.include	"gr_offsets.s"
	.include	"gr_hline.s"
	.include	"vapor_lock.s"

