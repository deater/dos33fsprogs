; Apple II Megademo

; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"


	;===================
	; set graphics mode
	;===================
	jsr	HOME

	; C64 Opening Sequence

	jsr	c64_opener

	; Falling Apple II

	jsr	falling_apple

	; Starring Screens

	; E-mail arriving

	; Leaving house

	; Riding bird

	; Waterfall

	; Enter ship

	; Fly in space

	; Arrive

	; Fireworks

	jsr	fireworks

	; Game over
game_over_man:
	jmp	game_over_man

	;===================
	; Loop Forever
	;===================
loop_forever:
	jmp	loop_forever


	.include	"lz4_decode.s"
	.include	"c64_opener.s"
	.include	"falling_apple.s"
.align $100
	.include	"gr_offsets.s"
	.include	"gr_hline.s"
	.include	"vapor_lock.s"
	.include	"delay_a.s"
	.include	"wait_keypress.s"
	.include	"random16.s"
.align $100
	.include	"fireworks.s"
	.include	"hgr.s"
	.include	"move_letters.s"
