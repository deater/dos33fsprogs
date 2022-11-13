; Apple II graphics/music in 1k

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"


apple2_desire:

	;=================
	; init vars

	lda	#0			; TODO: move to ay init
	sta	FRAME
	sta	WHICH_TRACK
	sta	BAMP_COUNTDOWN

	;===================
	; music Player Setup

	; assume mockingboard in slot#4

	; inline mockingboard_init

.include "mockingboard_init.s"

.include "tracker_init.s"

	jsr	HGR			; enable lo-res graphics

	cli				; enable music


.include "logo_intro.s"

game_loop:
	jmp	game_loop


.include "interrupt_handler.s"
.include "mockingboard_constants.s"

; logo
letter_d:
.include	"./letters/d.inc"
letter_e:
.include	"./letters/e.inc"
letter_s:
.include	"./letters/s.inc"
letter_i:
.include	"./letters/i.inc"
letter_r:
.include	"./letters/r.inc"

; music
.include	"mA2E_4.s"

