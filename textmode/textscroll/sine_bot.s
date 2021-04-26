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

;	jsr	SETTXT		; set lo-res text mode

;	jsr	HOME

next_frame:

	ldx	#39
text_loop:

	txa
	clc
	adc	FRAME
	and	#$f
	tay

	lda	cosine,Y
	tay

	lda	gr_offsetsh,Y
	clc
	adc	DRAW_PAGE
	sta	smc+2
	lda	gr_offsetsl,Y
	sta	smc+1


	txa
	and	#$f
	tay

	lda	apple,Y
	ora	#$80
smc:
	sta	$400,X

	dex
	bpl	text_loop

flip_pages:
	;	X is $FF at this point
	;	ldx	#0
	inx

	lda     DRAW_PAGE
	beq	done_page
	inx
done_page:
	ldy	PAGE0,X         ; set display page to PAGE1 or PAGE2

	eor	#$4             ; flip draw page between $400/$800
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
	.byte " APPLE ][ 4EVER "

cosine:
	.byte 3,3,3,2,2,1,0,0,0,0,0,1,1,2,3,3

gr_offsetsh:
	.byte $4,$4,$5,$5
gr_offsetsl:
	.byte $00,$80,$00,$80

blah:
	; want this to be at $3F5, is at $383
	; so load at $372

	jmp	move
