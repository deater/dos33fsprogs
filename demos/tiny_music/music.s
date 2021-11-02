; Tiny Mockingboard Player


; proposed format
; CCOONNNN -- c=channel, o=octave, n=note
; 11LLLLLL -- L=length

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"


	;==========================================

tiny_music:

	;===================
	;

	;===================
	; Player Setup

	lda	#0
	sta	DONE_PLAYING
	lda	#1
	sta	LOOP

	; assume mockingboard in slot#4

	jsr	mockingboard_init
	jsr	mockingboard_setup_interrupt
	jsr	reset_ay_both
	jsr	clear_ay_both

start_interrupts:
	cli

	rts

.include        "mockingboard_setup.s"
.include        "interrupt_handler.s"

	.include "nozp.inc"

