; Tiny Mockingboard Player

SONG_L	= $70
SONG_H	= $71
SONG_OFFSET = $72
SONG_COUNTDOWN = $73



; proposed format
; CCOONNNN -- c=channel, o=octave, n=note
; 11LLLLLL -- L=length
; 11LLLLLL -- wait time

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


	lda	#<yankee_doodle_song
	sta	SONG_L
	lda	#>yankee_doodle_song
	sta	SONG_H

	; assume mockingboard in slot#4

	jsr	mockingboard_init
	jsr	mockingboard_setup_interrupt
	jsr	reset_ay_both
	jsr	clear_ay_both

	jsr	init_registers
start_interrupts:
	cli

forever:
	jmp	forever


.include        "mockingboard_setup.s"
.include        "interrupt_handler.s"

	.include "nozp.inc"

	.include "yankee_music.s"
