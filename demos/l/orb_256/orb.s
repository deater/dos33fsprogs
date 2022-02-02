; orb

; this was found accidentally when trying to draw circles
; it's doing Bresenham circle algo I think, which does weird
;	things when radius=0

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

	lda	#0
	sta	XX			; XX = 0

	stx	YY			; YY =R (X is R here)

	lda	#3			; D=3-2*R
	sec
	sbc	R
	sbc	R
	sta	D

	; always odd, never zero

	bne	do_plots		; bra	skip ahead first time through

circle_loop:
	inc	XX			; XX=XX+1

	lda	XX			; XX is common both paths
	ldy	#6			; default path add 6

	; IF D>0 THEN Y=Y-1:D=D+4*(X-Y)+10
	bit	D			; check if negative w/o changing A
	bmi	d_negative

	dec	YY			; YY=YY-1


.if 0
d_positive:
	; D=D+4*(XX-YY)+10

	; XX is already in A
	sec
	sbc	YY
	asl
	asl
	clc
	adc	#10
	jmp	store_D

d_negative:
	; ELSE D=D+4*X+6
;	lda	XX
	asl
	asl
	clc
	adc	#6
store_D:
	adc	D
	sta	D
.endif

d_positive:
	; D=D+4*(XX-YY)+10

	; XX is already in A
	sec
	sbc	YY
	ldy	#10
d_negative:
	; ELSE D=D+4*(XX)+6
common_D:
	sty	DADD
	asl
	asl
	clc
	adc	DADD
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

;	ldy	#0
;	ldx	#0

;	jsr	HLINRL		; plot relative (X,A), (Y)
	jsr	combo_hlinrl
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

	cpx	#48			; run until R=48
	bne	draw_next		; loop	(GOTO 1)

rdone:
