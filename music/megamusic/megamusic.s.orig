; Apple II Megademo

; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"


megamusic_start:				; this should end up at $4000

	lda	#0
	sta	MB_FRAME
	sta	MB_PATTERN

	;===================
	; Init mockingboard
	;===================
	jsr mockingboard_init

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	; apple

	jsr	falling_apple

	;==================
	; Game over
	;==================
	; we never get here
game_over_man:
	jmp	game_over_man


	.include	"falling_apple.s"
	.include	"gr_unrle.s"
	.include	"gr_copy.s"
.align $100
	.include	"gr_offsets.s"
	.include	"gr_hline.s"
	.include	"vapor_lock.s"
	.include	"delay_a.s"
.align $100
	.include	"mockingboard.s"
	.include	"play_music.s"

;============================
; Include Lores Graphics
; No Alignment Needed
;============================

;  falling_apple
.include "apple_40_96.inc"

