; Apple II graphics/music in 1k

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"

; 466 bytes -- original from D2 demo
; 436 bytes -- left channel only
; 427 bytes -- optimize init a bit
; 426 bytes -- terminate init with $FF rather than extra $00
; 424 bytes -- move inits to zero together
; 414 bytes -- update ay output to write all registers
; 405 bytes -- more optimizing the interrupt handler
; 398 bytes -- only put song address one place
; 393 bytes -- don't keep song offset in Y
; 390 bytes -- use Y instead of X
; 388 bytes -- optimizing octave selection

d2:

	;===================
	; music Player Setup

tracker_song = peasant_song

;	lda	#<peasant_song
;	sta	SONG_L
;	lda	#>peasant_song
;	sta	SONG_H

	; assume mockingboard in slot#4

	; inline mockingboard_init

.include "mockingboard_init.s"

.include "tracker_init.s"

	; start the music playing

	cli

bob:
	jmp	bob



	;================
	; halt music
	; stop playing
	; turn off sound
its_over:
	sei
	lda	#$3f
	sta	AY_REGS+7
	jsr	ay3_write_regs

stuck_forever:
	bne	stuck_forever


; music
.include	"mA2E_2.s"
.include        "interrupt_handler.s"
; must be last
.include        "mockingboard_setup.s"
