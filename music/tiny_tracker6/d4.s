; Apple II graphics/music in 1k

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"


d4:

	;===================
	; music Player Setup

tracker_song = peasant_song

	; assume mockingboard in slot#4

	; inline mockingboard_init

.include "mockingboard_init.s"

.include "tracker_init.s"

	jsr	SETGR			; enable lo-res graphics

	cli				; enable music
game_loop:


	jmp	game_loop

.include "interrupt_handler.s"
.include "mockingboard_constants.s"

; music
.include	"mA2E_4.s"

