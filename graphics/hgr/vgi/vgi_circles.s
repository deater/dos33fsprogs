; VGI_Circles


XX		= $70
MINUSXX		= $71
YY		= $72
MINUSYY		= $73
D		= $74
COUNT		= $75

	;========================
	; VGI circle
	;========================

	VGI_CCOLOR	= P0
	VGI_CX		= P1
	VGI_CY		= P2
	VGI_CR		= P3

vgi_circle:
	ldx	VGI_CCOLOR
	lda	COLORTBL,X
	sta	HGR_COLOR

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

	lda	VGI_CR
	sta	YY

	lda	#3
	sec
	sbc	VGI_CR
	sbc	VGI_CR
	sta	D

	jmp	do_plots

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
	adc	D
	adc	#10
	jmp	store_D

else:
	; ELSE D=D+4*X+6
	lda	XX
	asl
	asl
	clc
	adc	D
	adc	#6
store_D:
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

	; calc X co-ord

	lda	#7
	sta	COUNT
pos_loop:
	lda	COUNT
	and	#$4
	lsr
	tay

	lda	COUNT
	lsr
	bcc	xnoc
	iny
xnoc:
	lda	VGI_CX
	clc
	adc	XX,Y
	tax

	; calc y co-ord

	lda	COUNT
	lsr
	eor	#$2
	tay

	lda	VGI_CY
	clc
	adc	XX,Y

	ldy	#0

	jsr	HPLOT0		; plot at (Y,X), (A)

	dec	COUNT
	bpl	pos_loop


	; IFY>=XTHEN4
	lda	YY
	cmp	XX
	bcs	circle_loop

	jmp	vgi_loop




	;========================
	; VGI circle
	;========================
	; VGI_CCOLOR	= P0
	; VGI_CX	= P1
	; VGI_CY	= P2
	; VGI_CR	= P3

vgi_filled_circle:
	ldx	VGI_CCOLOR
	lda	COLORTBL,X
	sta	HGR_COLOR

	;===============================
	; draw filled circle
	;===============================
	; draw filled circle at (CX,CY) of radius R
	; signed 8-bit math so problems if R > 64?


	; XX=0 YY=R
	; D=3-2*R
	; GOTO6

	lda	#0
	sta	XX

	lda	VGI_CR
	sta	YY

	lda	#3
	sec
	sbc	VGI_CR
	sbc	VGI_CR
	sta	D

	jmp	do_filled_plots

filled_circle_loop:
	; X=X+1

	inc	XX

	; IF D>0 THEN Y=Y-1:D=D+4*(X-Y)+10
	lda	D
	bmi	filled_else

	dec	YY

	lda	XX
	sec
	sbc	YY
	asl
	asl
	clc
	adc	D
	adc	#10
	jmp	store_filled_D

filled_else:
	; ELSE D=D+4*X+6
	lda	XX
	asl
	asl
	clc
	adc	D
	adc	#6
store_filled_D:
	sta	D

do_filled_plots:
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
filled_pos_loop:

	; calc left side

	; calc X co-ord

	lda	COUNT
	ora	#$1
	eor	#$2
	tay
	lda	VGI_CX
	clc
	adc	XX,Y
	tax

	; calc y co-ord

	ldy	COUNT
	lda	VGI_CY
	clc
	adc	XX,Y

	ldy	#0

	pha			; save Y value for later

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
	bpl	filled_pos_loop


	; IFY>=XTHEN4
	lda	YY
	cmp	XX
	bcs	filled_circle_loop

	jmp	vgi_loop
