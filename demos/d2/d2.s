; Tiny Mockingboard Player

; 514B -- Initial implementation
; 423B -- inline everything
; 400B -- put register init at end of song
; 381B -- generate the frequency table

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


	lda	#<peasant_song
	sta	SONG_L
	lda	#>peasant_song
	sta	SONG_H

	; assume mockingboard in slot#4
	jsr	mockingboard_init

start_interrupts:
	cli

forever:
	jmp	moving


.include	"moving.s"

; music
.include	"peasant_music.s"
.include        "interrupt_handler.s"
; must be last
.include        "mockingboard_setup.s"

