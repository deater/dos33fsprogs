
CH	= $24
CV	= $25
BASL	= $28
BASH	= $29
SEEDL	= $4E

DRAW_PAGE	= $FF

PAGE0		= $C054

HGR		= $F3E2
SETTXT		= $FB39
TABV		= $FB5B		; store A in CV and call MON_VTAB
STORADV		= $FBF0		; store A at (BASL),CH, advancing CH, trash Y
MON_VTAB	= $FC22		; VTAB to CV
VTABZ		= $FC24		; VTAB to value in A
HOME		= $FC58
WAIT    = $FCA8                 ;; delay 1/2(26+27A+5A^2) us

COUT	= $FDED
COUT1	= $FDF0
COUTZ	= $FDF6		; cout but ignore inverse flag

ypos	= $2000
xpos	= $2100

move:
	jsr	HGR

	sta	DRAW_PAGE

	jsr	SETTXT


next_frame:
	ldx	#0
next_text:
	lda	xpos,X
	bne	not_new

new_text:
	jsr	random8
	and	#$1f
	adc	#$4
	sta	xpos,X

	jsr	random8
	and	#$f
	sta	ypos,X


not_new:
	lda	xpos,X
	sta	CH
	lda	ypos,X
	sta	CV

	jsr	MON_VTAB

	lda	BASH
	clc
	adc	DRAW_PAGE
	sta	BASH

	txa
	pha

	ldx	#0
print_loop:
	lda	text,X

	php

	ora	#$80
	jsr	STORADV
	inx

	plp

	bpl	print_loop

big_done:

	pla
	tax

	dec	xpos,X

	inx
	cpx	#20
	bne	next_text

flip_pages:
	ldx	#0

	lda     DRAW_PAGE
	beq	done_page
	inx
done_page:
	ldy	PAGE0,X         ; set display page to PAGE1 or PAGE2

	eor	#$4             ; flip draw page between $400/$800
        sta	DRAW_PAGE

	clc
	adc	#$4
	sta	BASH
	lda	#$0
	sta	BASL

clear_screen_outer:
	ldy	#$f8
clear_screen_inner:
	lda	#$A0		; space char
	sta	(BASL),Y	; 100 101 110 111
	dey
	cpy	#$FF
	bne	clear_screen_inner
	inc	BASH
	lda	BASH
	and	#$3
	bne	clear_screen_outer

	lda	#$50
	jsr	WAIT

	jmp	next_frame


	;=============================
        ; random8
        ;=============================
        ; 8-bit 6502 Random Number Generator
        ; Linear feedback shift register PRNG by White Flame
        ; http://codebase64.org/doku.php?id=base:small_fast_8-bit_prng

random8:
        lda     SEEDL                                                   ; 2
        beq     doEor                                                   ; 2
        asl                                                             ; 1
        beq     noEor   ; if the input was $80, skip the EOR            ; 2
        bcc     noEor                                                   ; 2
doEor:  eor     #$1d                                                    ; 2
noEor:  sta     SEEDL                                                   ; 2
	rts


text:
	.byte "HELL",'O'|$80

