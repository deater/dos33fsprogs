; Apple II graphics/music in 1k

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"


apple2_desire:

	; clear both pages of graphics
	jsr	HGR2

	; Y is 0 here

	dey				; color = $FF
	sty	HGR_BITS

	lda	#$20			; clear page1
	jsr	BKGND+2

	; A and Y are 0 now?

	;===================
	; music Player Setup

	; assume mockingboard in slot#4

	; inline mockingboard_init

.include "mockingboard_init.s"

.include "tracker_init.s"



	cli				; enable music
.if 0
forever:
	sta	OUTL
	sta	LINE

	lda	#$d0
	sta	OUTH

line_loop:
	lda	LINE
	jsr	HPOSN           ; (Y,X),(A)  (values stores in HGRX,XH,Y)

	; first top right
	ldy	#0
out_loop:
        lda	(OUTL),Y
        sta	(GBASL),Y

        dey
        bne	out_loop

        inc	LINE
        bne	line_loop

end:
	lda	WHICH_TRACK
	beq	forever
.endif






.include "logo_intro.s"

	;========================
	; flip pages forever
main_loop:
	lda	FRAME
	and	#$80
;	clc
;	rol
	asl
	rol
	tax
	lda	PAGE1,X

	lda	WHICH_TRACK
	beq	main_loop

rot_rot_rot:
	lda	#$0
	jsr	draw_apple
	inc	rot_rot_rot+1

	bne	blah
	dec	scale_smc
blah:
;	beq	main_loop
;	lda	AY_REGS+8
;	sta	HGR_SCALE




	lda	HGR_PAGE
	eor	#$60
	sta	HGR_PAGE

	bne	main_loop


.include "interrupt_handler.s"
.include "mockingboard_constants.s"

.include "apple_logo.s"

.include "draw_letter.s"

.include "freq.s"



.include "bamps.s"

letters_x:
        .byte 14,62,110,154,176,220
letters_l:
        .byte <letter_d,<letter_e,<letter_s,<letter_i,<letter_r,<letter_e
;letters_h:
;       .byte >letter_d,>letter_e,>letter_s,>letter_i,>letter_r,>letter_e

;.align $100

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

