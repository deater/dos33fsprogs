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

	lda	#0
	sta	DONE_PLAYING
	lda	#1
	sta	LOOP


	lda	#<song_track_a
	sta	SONG_L
	lda	#>song_track_a
	sta	SONG_H

	lda	#0
	sta	SONG_OFFSET
	sta	SONG_COUNTDOWN

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
