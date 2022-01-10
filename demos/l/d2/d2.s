; Apple II graphics/music in 1k

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"

; 466 bytes -- original from D2 demo
; 436 bytes -- left channel only
; 427 bytes -- optimize init a bit

d2:

	;===================
	; music Player Setup


	lda	#<peasant_song
	sta	SONG_L
	lda	#>peasant_song
	sta	SONG_H

	; assume mockingboard in slot#4

	; TODO: inline?

	jsr	mockingboard_init

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
	ldx	#7
	jsr	ay3_write_reg

stuck_forever:
	bne	stuck_forever



; music
.include	"mA2E_2.s"
.include        "interrupt_handler.s"
; must be last
.include        "mockingboard_setup.s"
