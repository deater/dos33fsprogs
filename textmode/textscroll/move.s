
CH	= $24
CV	= $25


HGR		= $F3E2
SETTXT		= $FB39
TABV		= $FB5B		; store A in CV and call MON_VTAB
STORADV		= $FBF0		; store A at (BASL),CH, advancing CH, trash Y
MON_VTAB	= $FC22		; VTAB to CV
VTABZ		= $FC24		; VTAB to value in A
HOME		= $FC58

COUT	= $FDED
COUT1	= $FDF0
COUTZ	= $FDF6		; cout but ignore inverse flag

ypos	= $2000
xpos	= $2100

move:
	jsr	HGR
	jsr	SETTXT


next_frame:
	ldx	#0
next_text:
	lda	xpos,X
	bne	not_new

new_text:
	lda	#30
	sta	xpos,X

	txa
	sta	ypos,X



not_new:
	lda	xpos,X
	sta	CH
	lda	ypos,X
	sta	CV

	jsr	MON_VTAB

	txa
	pha

	ldx	#0
big_loop:
	lda	text,X

	bmi	big_done

	ora	#$80
	jsr	STORADV
	inx
	bne	big_loop

big_done:

	pla
	tax

	dec	xpos,X

	inx
	cpx	#20
	bne	next_text

	jsr	HOME

	jmp	next_frame

text:
	.byte "HELL",'O'|$80

