; TOKEN D734
; OUTDO (print char in A), calls COUT
; COUT calls ($0036)

CH	= $24
CV	= $25
BASL	= $28
BASH	= $29
CSWL	= $36
SEEDL	= $4E
FORPTR	= $85
LOWTR	= $9B
FACL	= $9D
FACH	= $9E

FRAME		= $FA
XSAVE		= $FB
STACKSAVE	= $FC
YSAV		= $FD
COUNT		= $FE
DRAW_PAGE	= $FF

PAGE0		= $C054
GETCHAR		= $D72C		; loads (FAC),Y and increments FAC
TOKEN		= $D734
HGR		= $F3E2
SETTXT		= $FB39
TABV		= $FB5B		; store A in CV and call MON_VTAB
BASCALC		= $FBC1
STORADV		= $FBF0		; store A at (BASL),CH, advancing CH, trash Y
MON_VTAB	= $FC22		; VTAB to CV
VTABZ		= $FC24		; VTAB to value in A
HOME		= $FC58
CLREOL		= $FC9C		; clear (BASL),CH to end of line
CLREOLZ		= $FC9E		; clear (BASL),Y to end of line

WAIT    = $FCA8                 ;; delay 1/2(26+27A+5A^2) us

COUT	= $FDED
COUT1	= $FDF0
COUTZ	= $FDF6		; cout but ignore inverse flag

ypos	= $2000
xpos	= $2100
textl	= $2200
texth	= $2300
which	= $2400

move:
	lda	#<lowtr_fake
	sta	LOWTR
	lda	#<our_cout
	sta	CSWL

	lda	#>lowtr_fake
;	lda	#>our_cout		; should be same
	sta	LOWTR+1
	sta	CSWL+1

	jsr	HGR		; clear $2000 to 0
				; A=0 at end

	sta	DRAW_PAGE
	sta	FORPTR		; used to trick LIST

	jsr	SETTXT		; set lo-res text mode

next_frame:
	ldx	#0
next_text:
	lda	xpos,X			; load next text xpos
	bne	not_new			; if not zero, continue

new_text:

	jsr	random8
	and	#$f
	adc	#$8
	sta	xpos,X			; get random X value 4...35

	jsr	random8
	and	#$f
	sta	ypos,X			; get random Y 0..15

	jsr	random8
	ora	#$80
	sta	which,X			; random token


not_new:
	lda	ypos,X
	jsr	BASCALC			; (basl) is now right

	lda	xpos,X
	sta	CH

;	lda	BASH
;	clc
;	adc	DRAW_PAGE
;	sta	BASH

	lda	which,X

	stx	XSAVE			; save X

	tsx
	stx	STACKSAVE		; save stack

	jmp	TOKEN			; call ROM token code

after_token:

	ldx	STACKSAVE		; restore stack
	txs

	ldx	XSAVE			; restore X

	dec	xpos,X			; move left

	inx				; move to next one
	cpx	#16
	bne	next_text

	; X is 16 here

flip_pages:
;	ldx	#0

;	lda     DRAW_PAGE
;	beq	done_page
;	inx
;done_page:
;	ldy	PAGE0-16,X         ; set display page to PAGE1 or PAGE2

;	eor	#$4             ; flip draw page between $400/$800
;       sta	DRAW_PAGE

	;===============
	; clear screen

;	ldx	#24
clear_screen_loop:
;	txa
;	jsr	BASCALC		; A is BASL at end
;	lda	BASH
;	clc
;	adc	DRAW_PAGE
;	sta	BASH

;	ldy	#0
;	jsr	CLREOLZ
;	dex
;	bpl	clear_screen_loop


	; pause

;	lda	#100
;	jsr	WAIT

	jmp	next_frame


our_cout:
	cmp	#$8d		; list thinks end of line
	bne	regular_print
	pla			; fake rts
	pla
	jmp	after_token

regular_print:
	sty	YSAV
	ldy	CH
	sta	(BASL),Y
	inc	BASL
	ldy	YSAV
	rts


	;=============================
        ; random8
        ;=============================
        ; 8-bit 6502 Random Number Generator
        ; Linear feedback shift register PRNG by White Flame
        ; http://codebase64.org/doku.php?id=base:small_fast_8-bit_prng

random8:
	lda	SEEDL                                                   ; 2
	beq	doEor                                                   ; 2
	asl                                                             ; 1
	beq	noEor   ; if the input was $80, skip the EOR            ; 2
	bcc	noEor                                                   ; 2
doEor:	eor	#$1d                                                    ; 2
noEor:	sta	SEEDL                                                   ; 2
	rts

lowtr_fake:
	.byte $00,$00	; fake end to BASIC program

	; want jump to live at $3F5
	; currently at $383
	;	so want to load at $372
blah:
	jmp	move
