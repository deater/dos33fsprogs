; Apple II graphics/music in 1k

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"


apple2_desire:

	; clear both pages of graphics
	jsr	HGR2
	lda	#$ff
	sta	HGR_BITS
	lda	#$20
	jsr	BKGND+2

	; A and Y are 0 now?

	;===================
	; music Player Setup

	; assume mockingboard in slot#4

	; inline mockingboard_init

.include "mockingboard_init.s"

.include "tracker_init.s"



	cli				; enable music


.include "logo_intro.s"

	;========================
	; flip pages forever
main_loop:
	lda	FRAME
	and	#$80
	clc
	rol
	rol
	tax
	lda	PAGE1,X

;	lda	AY_REGS+7
;	sta	$5000
;	sta	$3000

	jmp	main_loop


.include "interrupt_handler.s"
.include "mockingboard_constants.s"

.include "apple_logo.s"

.include "draw_letter.s"

.include "freq.s"

letters_x:
        .byte 14,62,110,154,176,220
letters_l:
        .byte <letter_d,<letter_e,<letter_s,<letter_i,<letter_r,<letter_e
;letters_h:
;       .byte >letter_d,>letter_e,>letter_s,>letter_i,>letter_r,>letter_e

.include "bamps.s"

.align $100

.include "freq_h.s"

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
.include	"apple_shape.s"

