; Apple II graphics/music in 1k

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"

; goal is 332 bytes

; 319 bytes -- switch songs to mA2E_3
; 415 bytes -- double length of song
; 334 bytes -- merge length into value

; if can straddle interrupt vector, save 10 bytes
; if can guarantee Y is 0 on entry, save 2 bytes


d2:

	;===================
	; music Player Setup

tracker_song = peasant_song

	; assume mockingboard in slot#4

	; inline mockingboard_init

.include "mockingboard_init.s"

.include "tracker_init.s"

	; start the music playing

	cli

bob:
	lda	KEYPRESS
	bpl	bob

quiet:
	lda	#$3f
	sta	AY_REGS+7

end:
	brk



.include        "interrupt_handler.s"
.include	"mockingboard_constants.s"

; music
.include	"mA2E_3.s"
