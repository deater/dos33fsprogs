; Apple II graphics/music in 1k

; by deater (Vince Weaver) <vince@deater.net>

; Lovebyte 2023

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"


blue_flame:

	; clear both pages of graphics
	jsr	HGR2

	; A and Y are 0 now?

	;===================
	; music Player Setup

	; assume mockingboard in slot#4

	; inline mockingboard_init

.include "mockingboard_init.s"

.include "tracker_init.s"



	cli				; enable music

.include "letters.s"


.include "interrupt_handler.s"
.include "mockingboard_constants.s"

; music
.include	"SmallLove2.s"


