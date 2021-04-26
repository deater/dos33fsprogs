; 134 bytes -- start
; 127 bytes -- merge ypos into one lookup
; 119 bytes -- use BASCALC
; 107 bytes -- use built-in string

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

SET_GR          =       $C050
SET_TEXT        =       $C051

PAGE0		= $C054
GETCHAR		= $D72C		; loads (FAC),Y and increments FAC
TOKEN		= $D734
HGR		= $F3E2
COSTBL		= $F5BA
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
	lda	#0
	sta	DRAW_PAGE

next_frame:

	ldy	#39
text_loop:

	tya			; get YY to print at
;	clc
;	adc	FRAME
	and	#$f
	tax

	lda	cosine,X	; get cosine value
	jsr	BASCALC		; convert to BASL/BASH

	lda	BASH		; add so is proper page
	clc
	adc	DRAW_PAGE
	sta	BASH

	tya			; lookup char to print
	clc
	adc	FRAME
	and	#$f
	tax
;	lda	apple,X
	lda	$FB09,X		; 8 bytes of apple II
	cpx	#8
	bcc	blah2
;	ora	#$80
	lda	#$a0
blah2:
	sta	(BASL),Y	; print it

	dey			; loop
	bpl	text_loop

flip_pages:
	;	Y is $FF at this point
	;	ldy	#0
	iny

	lda     DRAW_PAGE
	beq	done_page
	iny
done_page:
	ldx	PAGE0,Y		; set display page to PAGE1 or PAGE2

	eor	#$4		; flip draw page between $400/$800
	sta	DRAW_PAGE

	;===============
	; clear screen

	ldx	#24
clear_screen_loop:
	txa
	jsr	BASCALC		; A is BASL at end
	lda	BASH
	clc
	adc	DRAW_PAGE
	sta	BASH

	ldy	#0
	jsr	CLREOLZ
	dex
	bpl	clear_screen_loop


	; pause

	lda	#200
	jsr	WAIT

	inc	FRAME

;	bmi	grmode

;	bit	SET_TEXT
;	jmp	next_frame

;grmode:
;	bit	SET_GR

	jmp	next_frame



apple:
;	.byte "][ ELPPA"
;	.byte " APPLE ][ 4EVER "

cosine:
;	.byte 3,3,3,2,2,1,0,0,0,0,0,1,1,2,3,3
	.byte 23,23,23,22,22,21,20,20,20,20,20,21,21,22,23,23

;	.byte $7d,$7d,$7d,$75,$75,$6d,$65,$65,$65,$65,$65,$6d,$6d,$75,$7d,$7d
;	.byte $fa,$fa,$fa,$ea,$ea,$da,$ca,$ca,$ca,$ca,$ca,$da,$da,$ea,$fa,$fa
	; 0111 1101         0111 0101      0110 0101    0110 1101

;gr_offsetsh:
;	.byte $4,$4,$5,$5
;gr_offsetsl:
;	.byte $00,$80,$00,$80

;gr_offsetsh:
;	.byte $6,$6,$7,$7
;gr_offsetsl:
;	.byte $50,$d0,$50,$d0

blah:
	; want this to be at $3F5, is at $383

	jmp	move
