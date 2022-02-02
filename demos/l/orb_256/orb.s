; orb

; this was found accidentally when trying to draw circles
; it's doing Bresenham circle algo I think, which does weird
;	things when radius=0

; FIXME: assume hcolor is 3 somehow?

orb:
	; a=0, y=0 here

	tax			; x=0

	dey			; set init color to white
	sty	HGR_COLOR	; set init color to white

draw_next:
	stx	R

	;===============================
	; draw circle
	;===============================
	; draw circle at (CX,CY) of radius R
	; signed 8-bit math so problems if R > 64?

	; XX=0 YY=R
	; D=3-2*R
	; GOTO6

	lda	#0
	sta	XX

;	lda	R
	stx	YY

	lda	#3
	sec
	sbc	R
	sbc	R
	sta	D

	; always odd, never zero

	bne	do_plots		; bra

circle_loop:
	; X=X+1

	inc	XX

	; IF D>0 THEN Y=Y-1:D=D+4*(X-Y)+10
	lda	D
	bmi	else

	dec	YY

	lda	XX
	sec
	sbc	YY
	asl
	asl
	clc
	adc	#10
	jmp	store_D

else:
	; ELSE D=D+4*X+6
	lda	XX
	asl
	asl
	clc
	adc	#6
store_D:
	adc	D
	sta	D

do_plots:
	; setup constants

	lda	XX
	eor	#$FF
	sta	MINUSXX
	inc	MINUSXX

	lda	YY
	eor	#$FF
	sta	MINUSYY
	inc	MINUSYY

	; HPLOT CX+X,CY+Y
	; HPLOT CX-X,CY+Y
	; HPLOT CX+X,CY-Y
	; HPLOT CX-X,CY-Y
	; HPLOT CX+Y,CY+X
	; HPLOT CX-Y,CY+X
	; HPLOT CX+Y,CY-X
	; HPLOT CX-Y,CY-X

	lda	#3
	sta	COUNT
pos_loop:

	; calc left side

	; calc X co-ord

	lda	COUNT
	ora	#$1
	eor	#$2
	tay
;	lda	CX
	lda	#128
	clc
	adc	XX,Y
	tax

	; calc y co-ord

	ldy	COUNT
;	lda	CY
	lda	#96
	clc
	adc	XX,Y

	ldy	#0

	jsr	HPLOT0		; plot at (Y,X), (A)


	; calc right side
	lda	COUNT
	and	#$2
	eor	#$2
	tay
	lda	XX,Y
	asl

	ldy	#0
	ldx	#0

	jsr	HLINRL		; plot relative (X,A), (Y)
				; so in our case (0,XX*2),0



	dec	COUNT
	bpl	pos_loop


	; IFY>=XTHEN4
	lda	YY
	cmp	XX
	bcs	circle_loop

done:
	ldx	R
	inx				; increment radius
	jsr	HCOLOR1			; use as color

	cpx	#48			; loop
	beq	rdone
	; GOTO1
	jmp	draw_next

rdone:

