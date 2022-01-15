; Apple II graphics/music in 1k

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"

; aiming for under 256

; 310 bytes -- initial
; 268 bytes -- strip out interrupts
; 262 bytes -- simplify init
; 261 bytes -- optimize init more
; 253 bytes -- optimize var init
; 252 bytes -- bne vs jmp

d2:

	;===================
	; music Player Setup

tracker_song = peasant_song

	; assume mockingboard in slot#4

	; inline mockingboard_init

.include "mockingboard_init.s"

.include "tracker_init.s"

game_loop:

	; start the music playing

.include "play_frame.s"


	; delay 20Hz, or 1/20s = 50ms

	lda	#140
	jsr	WAIT

	beq	game_loop


; music
.include	"mA2E_2.s"

